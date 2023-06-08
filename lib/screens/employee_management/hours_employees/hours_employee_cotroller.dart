import 'package:appba/commons/API/api_clock_in.dart';
import 'package:appba/commons/API/api_employee.dart';
import 'package:appba/commons/API/api_notification.dart';
import 'package:appba/commons/API/api_payslip.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/payslip_model.dart';
import 'package:appba/commons/Models/notification.dart';

import 'package:flutter/material.dart';

class HoursEmployeeController {
  Employee _employee;
  HoursEmployeeController(this._employee);
  Future<List<Employee>> getNotifications() {
    return ApiClockIn.getHoursMonthDepartment(_employee.departamento!);
  }
}
