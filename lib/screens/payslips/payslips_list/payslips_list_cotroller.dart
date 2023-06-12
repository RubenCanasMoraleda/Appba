import 'package:appba/commons/API/api_payslip.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/payslip_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class PayslipListController {
  final Employee _employee;

  int? horasTotales, horasRealizadas;

  PayslipListController(
    this._employee,
  );

  Future<List<Payslip>> getPayslips() {
    return ApiPayslip.getPayslipsFromEmployee(_employee);
  }

  Future downloadPayslip(Payslip payslip, Employee employee) async {
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();

    bool storage = await Permission.manageExternalStorage.status.isGranted;

    if (storage) {
      final file = await ApiPayslip.downloadPayslip(payslip, employee);
      if (file == null) return;

      print("Path ${file.path}");
      // print("Path ${file.}");

      final result = await OpenFile.open(file.path);

      print(result.message);
    } else {
      Fluttertoast.showToast(
          msg: "No se puede acceder al almacenamiento del dispositivo",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      print("putos permisos de mierda");
    }
  }
}
