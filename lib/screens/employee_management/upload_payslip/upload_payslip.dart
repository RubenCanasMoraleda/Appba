import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/payslip_model.dart';
import 'package:appba/screens/employee_management/upload_payslip/upload_payslip_controller.dart';
import 'package:flutter/material.dart';

import '../../../assets/apba_theme/colors/apba_colors.dart';
import '../../../commons/custom_widgets/confirmation_dialog.dart';
import '../../../commons/custom_widgets/loading_list.dart';

class UploadPayslip extends StatefulWidget {
  final Employee employee;

  const UploadPayslip(this.employee, {super.key});

  @override
  State<UploadPayslip> createState() => _UploadPayslipState();
}

class _UploadPayslipState extends State<UploadPayslip> {
  late UploadPayslipcontroller _controller;

  @override
  void initState() {
    _controller = UploadPayslipcontroller(widget.employee);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _controller.getEmployeesFromDepartment(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount:
                    snapshot.data!.length > 60 ? 60 : snapshot.data?.length,
                itemBuilder: (context, index) {
                  Color background = index % 2 == 0
                      ? ApbaColors.background1
                      : ApbaColors.background2;
                  return Container(
                    decoration: BoxDecoration(
                        color: background,
                        border: const Border(
                            bottom: BorderSide(color: ApbaColors.border1))),
                    child: ExpansionTile(
                      title: Text(index.toString()),
                      children: [
                        Row(
                          children: [
                            // TODO boton subir archivo
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    showAlertDialog(context, onConfirm: () {
                                      _controller
                                          .getFile(snapshot.data![index]);
                                    });
                                  },
                                  child: Text("Emitir Nómina")),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                });
          } else {
            return LoadingList.of(
                60,
                ListTile(
                  title: Container(
                    height: 15,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ));
          }
        });
  }
}
