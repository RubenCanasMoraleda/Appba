// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
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
    var dio = Dio();
    var mime = lookupMimeType(filename);
    String url = "${Api.EMPLOYEE}uploadPayslip";
    FormData formData = FormData.fromMap({
      "empleado": employee.id,
      "file": await MultipartFile.fromFile(filename,
          contentType: MediaType.parse(mime!))
    });

    var request = await dio.post(url,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! > 0;
          },
        ));

    if (request.statusCode == 415) {
      Fluttertoast.showToast(
          msg: "El archivo seleccionado no es un pdf",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } else if (request.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Nómina subida correctamente",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
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
      return null;
    }
  }
}
