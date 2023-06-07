import 'package:appba/commons/API/api.dart';
import 'package:appba/commons/Models/notification.dart';
import 'package:appba/screens/notifications/create_notification/create_notification.dart';

class ApiNotification {
  static Future<List<Notificacion>> getNotifications() async {
    dynamic res = await Api.GET_REQUEST(Api.NOTIFICATION);
    List<Notificacion> notification = [];
    List<dynamic> fetched = res["data"];

    for (var item in fetched) {
      notification.add(Notificacion.fromJson(item));
    }

    return notification;
  }

  static Future<Notificacion?> createNotification(
      String title, String description) async {
    DateTime now = DateTime.now();
    dynamic body = {
      "fecha": now.toString(),
      "titulo": title,
      "descripcion": description
    };
    dynamic res = await Api.POST_REQUEST(Api.NOTIFICATION, body);

    Notificacion notificacionCreated = Notificacion.fromJson(res["data"]);

    return notificacionCreated;
  }

  static Future<List<Notificacion>> getFakeNotifications() {
    return Future.delayed(const Duration(seconds: 3), () {
      return List.generate(
          15,
          (index) => Notificacion(
              id: index,
              date: "2023-05-$index",
              description: "vacunacion de colera $index",
              title: "Vacunacion $index"));
    });
  }
}
