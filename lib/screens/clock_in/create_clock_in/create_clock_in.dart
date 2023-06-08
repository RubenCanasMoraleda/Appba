import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/assets/apba_theme/typography/apba_typography.dart';
import 'package:appba/commons/Models/clock_in.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/locations.dart';
import 'package:appba/screens/clock_in/create_clock_in/create_clock_in_controller.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class CreateClockIn extends StatefulWidget {
  final Employee employee;

  const CreateClockIn(this.employee, {super.key});

  @override
  State<CreateClockIn> createState() => _CreateClockInState();
}

class _CreateClockInState extends State<CreateClockIn> {
  late final CreateClockInController _controller;
  late StreamSubscription<Position> streamPosition;
  Position? position;
  bool userCentered = true;

  static List<Category> dropdownList = [
    Category.autoridadPortuaria,
    Category.aduana,
    Category.apmTerminals,
    Category.capitaniaMaritima,
    Category.estacionesMaritimas,
    Category.puestoInspeccionFronterizo,
    Category.terminalTraficoPesado,
    Category.totalTerminalInternational
  ];

  Category dropdownValue = dropdownList.first;
  final _formKey = GlobalKey<FormState>();

  List<Location> locations = [];
  Location? first;
  LatLng? center;

  @override
  void initState() {
    super.initState();
    _controller = CreateClockInController(widget.employee);

    setUpGps();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streamPosition.cancel();
    super.dispose();
  }

  void setUpGps() async {
    await _controller.init();
    streamPosition = _controller.streamPosition!.listen(
      (event) {
        super.setState(() {
          position = event;
          // print(position);
          // print(position!.heading);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MapController mapController = MapController();
    var marks = <Marker>[];
    Location? clockInLocation;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Crear Marcaje',
          // style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Builder(builder: (context) {
          if (position != null) {
            for (var element in locations) {
              marks.add(Marker(
                  rotate: true,
                  point: LatLng(element.lat!, element.long!),
                  builder: (context) => const Icon(
                        FontAwesomeIcons.locationDot,
                        color: Colors.red,
                      )));
            }
            return Center(
              child: Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Stack(children: [
                    FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        center: center ??
                            LatLng(position!.latitude, position!.longitude),
                        zoom: 15,
                      ),
                      children: [
                        TileLayer(
                          maxZoom: 19,
                          urlTemplate:
                              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        ),
                        MarkerLayer(
                          markers: marks +
                              [
                                Marker(
                                    rotate: true,
                                    point: LatLng(position!.latitude,
                                        position!.longitude),
                                    builder: (context) => Transform.rotate(
                                          angle: position!.heading - 0.6,
                                          child: const Icon(
                                            FontAwesomeIcons.locationArrow,
                                            color: Colors.red,
                                          ),
                                        )),
                              ],
                        )
                      ],
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              mapController.move(
                                  LatLng(
                                      position!.latitude, position!.longitude),
                                  15);
                            },
                            style: ApbaButtonStyle.secondaryIconBlueButtonSmall
                                .copyWith(
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.all(0))),
                            child: const FaIcon(
                                FontAwesomeIcons.locationCrosshairs)),
                      ),
                    ),
                  ]),
                ),
                const Text(
                  "Ubicacion",
                  style: ApbaTypography.bodyHighlight,
                ),
                const SizedBox(
                  height: 15,
                ),
                DropdownButton<Category>(
                  value: dropdownValue,
                  elevation: 16,
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Icon(
                      FontAwesomeIcons.chevronDown,
                      color: ApbaColors.backgroundBlue,
                    ),
                  ),
                  style: ApbaTypography.body1,
                  alignment: Alignment.center,
                  onChanged: (Category? value) async {
                    dynamic loc = await _controller.findLocation(value!);
                    setState(() {
                      locations = loc;
                      dropdownValue = value;
                      first = locations.first;
                      _controller.clockInLocation = first;
                      center = LatLng(first!.lat!, first!.long!);
                      mapController.move(
                          center ??
                              LatLng(position!.latitude, position!.longitude),
                          13);
                    });
                  },
                  items: dropdownList
                      .map<DropdownMenuItem<Category>>((Category value) {
                    return DropdownMenuItem<Category>(
                      value: value,
                      child: Text(value.value),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 15,
                ),
                Builder(builder: (context) {
                  if (locations.isNotEmpty && locations.length > 1) {
                    return DropdownButton<Location>(
                      value: first,
                      elevation: 16,
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(
                          FontAwesomeIcons.chevronDown,
                          color: ApbaColors.backgroundBlue,
                        ),
                      ),
                      style: ApbaTypography.body1,
                      alignment: Alignment.center,
                      onChanged: (Location? value) async {
                        setState(() {
                          center = LatLng(value!.lat!, value.long!);
                          first = value;
                          _controller.clockInLocation = value;
                          userCentered = false;
                          mapController.move(
                              center ??
                                  LatLng(
                                      position!.latitude, position!.longitude),
                              13);
                        });
                      },
                      items: locations
                          .map<DropdownMenuItem<Location>>((Location value) {
                        return DropdownMenuItem<Location>(
                          value: value,
                          child: Text(value.name ?? ""),
                        );
                      }).toList(),
                    );
                  }
                  return Container();
                }),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    // height: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton(
                        onPressed: () {
                          print(position?.longitude);
                          _controller.createClockIn(position!, context);
                        },
                        child: Text(
                            _controller.lastClockIn?.tipo == Tipo.entrada
                                ? "Fichar Entrada"
                                : "Fichar salida")))
              ]),
            );
          } else {
            return Text("Loading");
          }
        }),
      ),
    );
  }
}
