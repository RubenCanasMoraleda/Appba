import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:appba/commons/API/api.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/payslip_model.dart';

class ApiPayslip {
  static Future<List<Payslip>> getPayslipsFromEmployee(
      Employee employee) async {
    dynamic res =
        await Api.GET_REQUEST("${Api.EMPLOYEE}payslip/${employee.id}");

    List<Payslip> payslips = [];
    List<dynamic> fetched = res["nomina"];

    for (var item in fetched) {
      payslips.add(Payslip.fromJson(item));
    }

    return payslips;
  }

  static Future uploadPayslip(String filename, Employee employee) async {
    String url = "${Api.EMPLOYEE}uploadPayslip";
    print(url);
    print("filename: " + filename);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields["empleado"] = "${employee.id}";
    request.files.add(await http.MultipartFile.fromPath('file', filename));
    var res = await request.send();
    print(res.statusCode);
  }

  static Future<File?> downloadPayslip(
      Payslip payslip, Employee employee) async {
    String url =
        "${Api.EMPLOYEE}downloadPayslip/${employee.dni}/${payslip.path}";
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File("${appStorage.path}/nomina-${payslip.fecha}.pdf");

    try {
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          contentType: "aplication/pdf",
          followRedirects: false,
        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
