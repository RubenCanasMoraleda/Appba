import 'package:appba/commons/Models/notification.dart';

class ApiNotification {
  static Future<List<Notificacion>> getNotifications() {
    Future<List<Notificacion>> notifications = getFakeNotifications();

    return notifications;
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
