import 'package:appba/commons/API/api_notification.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/notification.dart';

class NotificationListController {
  int? horasTotales, horasRealizadas;

  NotificationListController();

  Future<List<Notificacion>> getNotifications() {
    return ApiNotification.getNotifications();
  }

  bool canAddNotifications(Employee employee) {
    if (employee.rol == "recursos humanos" ||
        employee.rol == "jefe recursos humanos") {
      return true;
    }
    return false;
  }
}
