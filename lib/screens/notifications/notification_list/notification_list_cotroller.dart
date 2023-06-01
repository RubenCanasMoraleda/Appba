import 'package:appba/commons/API/api_notification.dart';
import 'package:appba/commons/API/api_payslip.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/payslip_model.dart';
import 'package:appba/commons/Models/notification.dart';

import 'package:flutter/material.dart';

class NotificationListController {
  int? horasTotales, horasRealizadas;

  NotificationListController();

  Future<List<Notificacion>> getNotifications() async {
    return ApiNotification.getNotifications();
  }
}
