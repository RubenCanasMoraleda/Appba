// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:appba/commons/API/api_clock_in.dart';
import 'package:appba/commons/API/api_location.dart';
import 'package:appba/commons/Models/clock_in.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/locations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

    ClockIn? clockIn;
    if (distance < 50) {
      Fluttertoast.showToast(
          msg: "Estas demasiado lejos de ${clockInLocation?.name}");
    } else {
      Tipo tipo =
          lastClockIn?.tipo == Tipo.entrada ? Tipo.salida : Tipo.entrada;
      clockIn = await ApiClockIn.createClockIn(_employee, tipo);
    }
    lastClockIn = clockIn;
    return clockIn;
  }

  Future<List<Location>?> findLocation(Category category) async {
    List<Location>? locations;

    locations = await ApiLocation.getLocationsFromCategory(category);

    return locations;
  }

  Future<void> init() async {
    serviceEnabled = await _checkGpsStatus();
    await getLasClockIn();
    // await getLasClockIn();
    // recentCategories = [] as Map<Category, List<Location>>?;
    notifyListeners();
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission;

    if (isEnable) {
      serviceEnabled = isEnable;
      notifyListeners();

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
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
        listenToLocationChanges();
      }
    }
    notifyListeners();
    return isEnable;
  }

  void listenToLocationChanges() {
    streamPosition = Geolocator.getPositionStream();
    notifyListeners();
  }
}
