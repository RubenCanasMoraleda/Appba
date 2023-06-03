import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/screens/employee_management/accept_deny_request/accept_deny_request.dart';
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
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: const TabBar(
            indicatorColor: ApbaColors.primaryOrange60,
            labelColor: ApbaColors.primaryBlack,
            tabs: [
              Tab(
                icon: Icon(FontAwesomeIcons.user),
                text: "Empleados",
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.hourglassEnd),
                text: "Horas",
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.moneyBill1),
                text: "Nominas",
              ),
            ],
          ),
          body: TabBarView(
            children: [
              AcceptDenyRequest(widget.employee),
              Icon(Icons.directions_transit),
              UploadPayslip(widget.employee)
            ],
          ),
        ));
  }
}
