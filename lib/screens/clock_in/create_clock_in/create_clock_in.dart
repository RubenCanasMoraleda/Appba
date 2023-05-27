import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';

class CreateClockIn extends StatefulWidget {
  const CreateClockIn({super.key});

  @override
  State<CreateClockIn> createState() => _CreateClockInState();
}

class _CreateClockInState extends State<CreateClockIn> {
  @override
  Widget build(BuildContext context) {
    final MapController mapController = MapController();
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
          Container(
            width: 300,
            height: 300,
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: LatLng(36.157057, -5.355161),
                zoom: 19,
              ),
              children: [
                TileLayer(
                  maxZoom: 19,
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                        rotate: true,
                        point: LatLng(36.157057, -5.355161),
                        builder: (context) => const Icon(
                              FontAwesomeIcons.locationDot,
                              color: Colors.red,
                            ))
                  ],
                )
              ],
            ),
          ),
          const Text("Ubicacion"),
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
