import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/assets/apba_theme/styles/apba_styles.dart';
import 'package:appba/assets/apba_theme/typography/apba_typography.dart';
import 'package:appba/commons/Models/clock_in.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/locations.dart';
import 'package:appba/commons/custom_widgets/confirmation_dialog.dart';
import 'package:appba/screens/clock_in/create_clock_in/create_clock_in_controller.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  late StreamSubscription<ServiceStatus> serviceStatus;
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
    Category.totalTerminalInternational,
    Category.centrosEducativos
  ];

  Category dropdownValue = dropdownList.first;

  List<Location> locations = [];
  Location? first;
  LatLng? center;
  ServiceStatus locationStatus = ServiceStatus.enabled;

  @override
  void initState() {
    super.initState();
    _controller = CreateClockInController(widget.employee);
    loadFirstLocation();
    setUpGps();
  }

  loadFirstLocation() async {
    locations = (await _controller.findLocation(dropdownList[0]))!;
    _controller.clockInLocation = locations[0];
  }

  @override
  void dispose() {
    streamPosition.cancel();
    super.dispose();
  }

  void setUpGps() async {
    await _controller.init();
    serviceStatus = Geolocator.getServiceStatusStream().listen((event) async {
      if (event == ServiceStatus.disabled) {
        await showAlertDialog(context,
            title: "Acceso a la ubicación",
            message:
                "La ubicación del dispositivo no está activada, para poder marcar es necesario saber su unicación. \n ¿Deasea activarla?",
            onConfirm: () async {
          Geolocator.openLocationSettings();
        });
      }
      setState(() {
        locationStatus = event;
      });
    });
    streamPosition = _controller.streamPosition!.listen(
      (event) async {
        super.setState(() {
          position = event;
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
        centerTitle: true,
        title: const Text(
          'Crear Marcaje',
        ),
      ),
      body: SafeArea(
        child: Builder(builder: (context) {
          if (locationStatus == ServiceStatus.disabled) {
            return Center(
              child: SizedBox(
                height: 244,
                width: 300,
                child: Column(children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: const BoxDecoration(
                        borderRadius: ApbaStyles.borderRadiusL,
                        color: ApbaColors.semanticBackgroundHighlight1),
                    child: const Icon(
                        color: ApbaColors.semanticError,
                        FontAwesomeIcons.circleExclamation),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Ubicación del dispositivo desactivada",
                    style: ApbaTypography.headingTitle1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "El servicio de ubicacíon del dispositivo se encuentra desactivada, para poder realizar un marcaje es necesario activar dicho servicio",
                    textAlign: TextAlign.center,
                    style:
                        ApbaTypography.body2.copyWith(color: ApbaColors.text2),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextButton(
                      onPressed: () {
                        Geolocator.openLocationSettings();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Activar ubicacion",
                            style: ApbaTypography.buttonMedium
                                .copyWith(color: ApbaColors.semanticHighlight1),
                          ),
                          const Icon(
                            FontAwesomeIcons.chevronRight,
                            color: ApbaColors.semanticHighlight1,
                          )
                        ],
                      ))
                ]),
              ),
            );
          }
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
                        zoom: 19,
                        maxZoom: 19,
                      ),
                      children: [
                        TileLayer(
                          minZoom: 0,
                          maxZoom: 20,
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
                                    padding: const MaterialStatePropertyAll(
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
                  } else {
                    return const SizedBox(
                      height: 48,
                    );
                  }
                }),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              _controller
                                  .createClockIn(position!, context)
                                  // ignore: invalid_return_type_for_catch_error
                                  .catchError((e) => {
                                        Fluttertoast.showToast(
                                            msg: "Error al marcar")
                                      })
                                  .then((value) => {
                                        setState(
                                          () {
                                            _controller.lastClockIn = value;
                                          },
                                        ),
                                        if (value != null)
                                          {Navigator.pop(context)}
                                      });
                            },
                            child: Text(
                                _controller.lastClockIn?.tipo == Tipo.entrada
                                    ? "Fichar Salida"
                                    : "Fichar Entrada")),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            style: ApbaButtonStyle.dangerButton,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancelar marcaje")),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                )
              ]),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: ApbaColors.semanticHighlight2,
              ),
            );
          }
        }),
      ),
    );
  }
}
