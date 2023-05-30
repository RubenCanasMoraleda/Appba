import 'package:appba/screens/employee_management/accept_deny_request/accept_deny_request.dart';
import 'package:appba/screens/employee_management/upload_payslip/upload_payslip.dart';
import 'package:flutter/material.dart';

class EmployeeManagement extends StatefulWidget {
  const EmployeeManagement({super.key});

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
    return const DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TabBar(
            labelColor: Colors.amber,
            tabs: [
              Tab(
                icon: Icon(Icons.person),
                text: "Empleados",
              ),
              Tab(
                icon: Icon(Icons.hourglass_empty_sharp),
                text: "Horas",
              ),
              Tab(
                icon: Icon(Icons.payment),
                text: "Nominas",
              ),
            ],
          ),
          body: TabBarView(
            children: [
              AcceptDenyRequest(),
              Icon(Icons.directions_transit),
              UploadPayslip()
            ],
          ),
        ));
  }
}
