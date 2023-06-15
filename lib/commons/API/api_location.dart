import 'package:appba/commons/API/api.dart';
import 'package:appba/commons/Models/locations.dart';

class ApiLocation {
  static Future<List<Location>> getLocationsFromCategory(
      Category category) async {
    dynamic res =
        await Api.GET_REQUEST("${Api.LOCATION}byCategory/${category.key}");

    List<Location> locations = [];

    List<dynamic> fetched = res["data"];

    for (var item in fetched) {
      locations.add(Location.fromJson(item));
    }

    return locations;
  }
}
