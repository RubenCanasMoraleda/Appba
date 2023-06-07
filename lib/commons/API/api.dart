import 'dart:convert';
import 'package:http/http.dart' as http;

// const LOCAL_URL = Platform.OS=="ios"? 'http://localhost:5000/api' : 'http://10.0.2.2:5000/api';
const localJuanma = "192.168.0.14:8000";
const local = "192.168.1.128";
const dev = "appba-backend-app.fly.dev";
const prod = "eppic-iturri.com";

const current = dev;
const currentS =
    (current != local && current != localJuanma) ? "https://" : "http://";

const defaultErrorMessage =
    "Ha habido un error en nuestros servidores. Contacte con un administrador.";

class Endpoints {
  static String URL = current + "/api";
  static String AUTH = "/login";
  static String LOCATION = "/locations/";
  static String EMPLOYEE = "/empleados/";
  static String DEPARTMENT = "/departamentos/";
  static String CLOCK_IN = "/marcaje/";
  static String PAYSLIP = "/nomina/";
  static String REQUEST = "/solicitudes/";
  static String NOTIFICATION = "/notifications/";
}

class Api {
  Api._();

  static String URL = currentS + Endpoints.URL;
  static String AUTH = URL + Endpoints.AUTH;
  static String LOCATION = URL + Endpoints.LOCATION;
  static String EMPLOYEE = URL + Endpoints.EMPLOYEE;
  static String DEPARTMENT = URL + Endpoints.DEPARTMENT;
  static String CLOCK_IN = Api.URL + Endpoints.CLOCK_IN;
  static String PAYSLIP = URL + Endpoints.PAYSLIP;
  static String REQUEST = URL + Endpoints.REQUEST;
  static String NOTIFICATION = URL + Endpoints.NOTIFICATION;

  static Map<String, String> headers = {"Accept": "application/json"};

  static dynamic GET_REQUEST(String url) async {
    Uri uri = Uri.parse(url);
    // if (params != null) {
    //   uri = uri.replace(queryParameters: params);
    // }
    print(uri);
    final response = await http.get(uri, headers: headers);
    final code = response.statusCode;
    final rawJsonString = response.body;
    dynamic res = jsonDecode(rawJsonString);
    if (code >= 400 || res["status"] != 200) {
      String er = res["message"] ?? defaultErrorMessage;

      // throw ApiException(code: code, message: er);
    }
    print("codigo ${code}");
    print(res["message"]);
    return res;
  }

  static dynamic POST_REQUEST(String url, [Object? body]) async {
    final parsedUrl = Uri.parse(url);

    final response = await http.post(parsedUrl, headers: headers, body: body);

    final code = response.statusCode;

    final rawJsonString = response.body;

    dynamic res = jsonDecode(rawJsonString);

    if (code >= 400 || res["status"] != 200) {
      String er = res["error"] ?? defaultErrorMessage;

      // throw ApiException(code: code, message: er);
    }

    return res;
  }

  static dynamic PUT_REQUEST(String url, [Object? body]) async {
    final parsedUrl = Uri.parse(url);

    final response = await http.put(parsedUrl, headers: headers, body: body);
    final code = response.statusCode;

    final rawJsonString = response.body;

    dynamic res = jsonDecode(rawJsonString);

    if (code >= 400) {
      String er = res["message"] ?? defaultErrorMessage;

      // throw ApiException(code: code, message: er);
    }
    return res;
  }

  static dynamic DELETE_REQUEST(String url, [Object? body]) async {
    final parsedUrl = Uri.parse(url);
    final response = await http.delete(parsedUrl, headers: headers, body: body);
    final code = response.statusCode;
    final rawJsonString = response.body;

    dynamic res = jsonDecode(rawJsonString);

    if (code >= 400 || res["status"] != 200) {
      String er = res["message"] ?? defaultErrorMessage;

      // throw ApiException(code: code, message: er);
    }
    return res;
  }
}
