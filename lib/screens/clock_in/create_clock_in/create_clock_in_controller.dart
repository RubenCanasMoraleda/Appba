// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:appba/commons/API/api.dart';
import 'package:appba/commons/API/api_clock_in.dart';
import 'package:appba/commons/API/api_location.dart';
import 'package:appba/commons/Models/clock_in.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/locations.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CreateClockInController extends ChangeNotifier {
  final Employee _employee;

  // Future<Position>? position;
  // late Stream<Position> positionStream;
  Position? currentPosition;

  bool serviceEnabled = false;
  Location? clockInLocation;

  // Map<Category, List<Location>> recentCategories = {};

  late StreamSubscription<ServiceStatus> serviceStatus;
  Stream<Position>? streamPosition;

  CreateClockInController(this._employee);

  ClockIn? lastClockIn;

  Future<ClockIn> getLasClockIn() async {
    return lastClockIn =
        await ApiClockIn.getLastClockInTypeFromEmployee(_employee);
  }

  Future<ClockIn?> createClockIn(
      Position position, BuildContext context) async {
    double distance = Geolocator.distanceBetween(clockInLocation!.lat!,
        clockInLocation!.long!, position.latitude, position.longitude);

    double fakeDistance = Geolocator.distanceBetween(clockInLocation!.lat!,
        clockInLocation!.long!, clockInLocation!.lat!, clockInLocation!.long!);

    ClockIn? clockIn;
    if (distance > 10) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Estas demasiado lejos de ${clockInLocation?.name}"),
      ));
    } else {
      Tipo tipo = clockIn?.tipo == Tipo.entrada ? Tipo.salida : Tipo.entrada;
      clockIn = await ApiClockIn.createClockIn(_employee, tipo);
    }

    return clockIn;
  }

  Future<List<Location>?> findLocation(Category category) async {
    List<Location>? locations;

    // dynamic recentCategory;
    // print("recent :${recentCategories}");
    // if (recentCategories.isEmpty && recentCategories!.containsKey(category)) {
    //   locations = recentCategories[category];
    // } else {
    locations = await ApiLocation.getLocationsFromCategory(category);
    // recentCategory = <Category, List<Location>>{category: locations};
    //   recentCategories.addEntries(recentCategory);
    // }

    return locations;
  }

  Future<void> init() async {
    print("Service status ");
    serviceEnabled = await _checkGpsStatus();
    // await getLasClockIn();
    // recentCategories = [] as Map<Category, List<Location>>?;
    notifyListeners();
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission;

    print("enabled $isEnable");
    serviceStatus = Geolocator.getServiceStatusStream().listen((event) {
      final isEnable = event.index == 1;
      print("Service status $isEnable");
    });

    // if (isEnable) {
    //   listenToLocationChanges();
    // }
    serviceEnabled = isEnable;
    notifyListeners();

    if (isEnable) {
      print("entraen servicieEnable");
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        print("entraen permisos denied");
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print("entraen permisos denied 2");
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }
      // return Future.error('Location services are disabled.');

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        print("tiene permisos");
        listenToLocationChanges();
      }
    }
    notifyListeners();
    return isEnable;
  }

  void listenToLocationChanges() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
// locationSettings: locationSettings
    streamPosition = Geolocator.getPositionStream();
    print("Se inicia el stream");
    notifyListeners();
    // streamPosition.listen((Position? position) {
    //   print(position == null ? "Unknow" : "$position");
    //   currentPosition = position;
    //   print("current position$currentPosition");
    //   notifyListeners();
    // });
  }
}
