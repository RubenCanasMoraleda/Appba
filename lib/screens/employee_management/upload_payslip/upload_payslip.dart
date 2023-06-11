import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/payslip_model.dart';
import 'package:appba/screens/employee_management/upload_payslip/upload_payslip_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../assets/apba_theme/colors/apba_colors.dart';
import '../../../commons/custom_widgets/confirmation_dialog.dart';
import '../../../commons/custom_widgets/loading_list.dart';

class UploadPayslip extends StatefulWidget {
  final Employee employee;

  const UploadPayslip(this.employee, {super.key});

  @override
  State<UploadPayslip> createState() => _UploadPayslipState();
}

class _UploadPayslipState extends State<UploadPayslip>
    with AutomaticKeepAliveClientMixin<UploadPayslip> {
  late UploadPayslipcontroller _controller;
  late Future<List<Employee>> _employees;

  @override
  void initState() {
    _controller = UploadPayslipcontroller(widget.employee);
    loadEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: _employees,
        builder:
            (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              color: ApbaColors.semanticHighlight2,
              onRefresh: loadEmployees,
              child: ListView.builder(
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
                        title: Text(snapshot.data![index].nombre!),
                        children: [
                          GetUploadFileForm(_controller, snapshot, index)
                        ],
                      ),
                    );
                  }),
            );
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

  @override
  bool get wantKeepAlive => true;

  Future<void> loadEmployees() async {
    _employees = _controller.getEmployeesFromDepartment();
  }
}

class GetUploadFileForm extends StatefulWidget {
  final UploadPayslipcontroller controller;
  final AsyncSnapshot<List<Employee>> snapshot;
  final int index;
  const GetUploadFileForm(this.controller, this.snapshot, this.index,
      {super.key});

  @override
  State<GetUploadFileForm> createState() => _GetUploadFileFormState();
}

class _GetUploadFileFormState extends State<GetUploadFileForm> {
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(filePath == null
            ? "Aun no has seleccionado ningun archivo"
            : filePath!),
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  style: filePath == null
                      ? ApbaButtonStyle.primaryBlueButton
                      : ApbaButtonStyle.secondaryButton,
                  onPressed: () {
                    widget.controller.getFile().then((value) {
                      setState(() {
                        filePath = value;
                      });
                    });
                  },
                  child: const Text("Seleccionar Archivo")),
            )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                    style: filePath == null
                        ? ApbaButtonStyle.secondaryButton
                        : ApbaButtonStyle.primaryBlueButton,
                    onPressed: () {
                      if (filePath != null) {
                        showAlertDialog(context, onConfirm: () {
                          widget.controller.uploadFile(
                              filePath!, widget.snapshot.data![widget.index]);
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Selecciona un archivo primero");
                      }
                    },
                    child: const Text("Emitir Nómina")),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
