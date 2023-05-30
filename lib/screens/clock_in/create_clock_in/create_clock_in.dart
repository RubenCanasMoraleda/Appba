import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
            child: Text(
          'Crear Marcaje',
          // style: TextStyle(color: Colors.black),
        )),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Builder(builder: (context) {
            if (position != null) {
              // center = !userCentered
              //     ? LatLng(position!.latitude, position!.longitude)
              //     : center;
              print(center);
              locations.forEach((element) {
                marks.add(Marker(
                    rotate: true,
                    point: LatLng(element.lat!, element.long!),
                    builder: (context) => const Icon(
                          FontAwesomeIcons.locationDot,
                          color: Colors.red,
                        )));
              });
              return Container(
                width: 300,
                height: 300,
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
                                  point: LatLng(
                                      position!.latitude, position!.longitude),
                                  builder: (context) => Transform.rotate(
                                        angle: position!.heading - 0.6,
                                        child: const Icon(
                                          FontAwesomeIcons.locationArrow,
                                          color: Colors.red,
                                        ),
                                      )),
                            ],
                      )
                      // [
                      //   Marker(
                      //       rotate: true,
                      //       point: LatLng(36.157057, -5.355161),
                      //       builder: (context) => const Icon(
                      //             FontAwesomeIcons.locationDot,
                      //             color: Colors.red,
                      //           )),
                      // Marker(
                      //     rotate: true,
                      //     point:
                      //         LatLng(position!.latitude, position!.longitude),
                      //     builder: (context) => Transform.rotate(
                      //           angle: position!.heading - 0.6,
                      //           child: Icon(
                      //             FontAwesomeIcons.locationArrow,
                      //             color: Colors.red,
                      //           ),
                      //         )),
                      // ],
                      // )
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
                                LatLng(position!.latitude, position!.longitude),
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
              );
            } else {
              return Text("Loading");
            }
          }),
          const Text("Ubicacion"),
          DropdownButton<Category>(
            value: dropdownValue,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (Category? value) async {
              dynamic loc = await _controller.findLocation(value!);
              setState(() {
                locations = loc;
                print("loc ${loc.toString()}");
                print("location ${locations.toString()}");
                dropdownValue = value;
                first = locations.first;
                center = LatLng(first!.lat!, first!.long!);
                mapController.move(
                    center ?? LatLng(position!.latitude, position!.longitude),
                    13);
              });
            },
            items:
                dropdownList.map<DropdownMenuItem<Category>>((Category value) {
              return DropdownMenuItem<Category>(
                value: value,
                child: Text(value.value),
              );
            }).toList(),
          ),
          Builder(builder: (context) {
            print("location build ${locations.length}");
            print("center ${center}");
            if (locations.isNotEmpty && locations.length > 1) {
              return DropdownButton<Location>(
                value: first,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (Location? value) async {
                  // dynamic loc = await _controller.findLocation(value!);
                  setState(() {
                    center = LatLng(value!.lat!, value.long!);
                    // print("loc ${loc.toString()}");
                    print("location ${locations.toString()}");
                    first = value;
                    userCentered = false;
                    mapController.move(
                        center ??
                            LatLng(position!.latitude, position!.longitude),
                        13);
                  });
                },
                items:
                    locations.map<DropdownMenuItem<Location>>((Location value) {
                  return DropdownMenuItem<Location>(
                    value: value,
                    child: Text(value.name ?? ""),
                  );
                }).toList(),
              );
            }
            return Container();
          }),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        // height: MediaQuery.of(context).size.width / 2,
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text("Fichar"))),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                          style: ApbaButtonStyle.dangerButton,
                          onPressed: () {},
                          child: const Text("Cancelar")),
                    )
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      Switch(value: false, onChanged: (e) {}),
                      const Text("Entrada / Salida")
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
