import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/screens/employee_management/accept_deny_request/accept_deny_request.dart';
import 'package:appba/screens/employee_management/hours_employees/hours_employee.dart';
import 'package:appba/screens/employee_management/upload_payslip/upload_payslip.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmployeeManagement extends StatefulWidget {
  final Employee employee;

  const EmployeeManagement(this.employee, {super.key});

  @override
  State<EmployeeManagement> createState() => _EmployeeManagementState();
}

class _EmployeeManagementState extends State<EmployeeManagement>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<EmployeeManagement> {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
        length: getTabs(widget.employee).length,
        child: Scaffold(
          appBar: TabBar(
            indicatorColor: ApbaColors.primaryOrange60,
            labelColor: ApbaColors.primaryBlack,
            tabs: getTabs(widget.employee),
          ),
          body: TabBarView(children: getTabsViews(widget.employee)),
        ));
  }

  List<Widget> getTabs(Employee employee) {
    if (employee.rol == "recursos humanos" ||
        employee.rol == "jefe recursos humanos") {
      return const [
        Tab(
          icon: Icon(FontAwesomeIcons.envelope),
          text: "Solicitudes",
        ),
        Tab(
          icon: Icon(FontAwesomeIcons.hourglassEnd),
          text: "Horas",
        ),
        Tab(
          icon: Icon(FontAwesomeIcons.moneyBill1),
          text: "Nominas",
        ),
      ];
    } else {
      return const [
        Tab(
          icon: Icon(FontAwesomeIcons.envelope),
          text: "Solicitudes",
        ),
        Tab(
          icon: Icon(FontAwesomeIcons.hourglassEnd),
          text: "Horas",
        ),
      ];
    }
  }

  getTabsViews(Employee employee) {
    if (employee.rol == "recursos humanos" ||
        employee.rol == "jefe recursos humanos") {
      return [
        AcceptDenyRequest(employee),
        HoursEmployee(employee),
        UploadPayslip(employee)
      ];
    } else {
      return [
        AcceptDenyRequest(employee),
        HoursEmployee(employee),
      ];
    }
  }

  @override
  bool get wantKeepAlive => true;
}
