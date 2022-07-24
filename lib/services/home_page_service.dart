import 'dart:convert';
import 'dart:developer';

import 'package:dvmane/configuration/globals.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../PoJos/response/report_response_class.dart';
import '../PoJos/response/report_status_response_class.dart';

class HomePageService {
  Future<List<Data>> getReports(status) async {
    List<Data> list = [];
    try {
      var headers = await Globals().createHeaders();
      log("HEADERS:- $headers");
      var response = await http.get(
          Uri.parse(
              '${Globals.apiUrl}/api/reports/getReportsByStatus?status=$status'),
          headers: headers);

      log("HOME_PAGE_RESPONSE:- ${response.body}");

      if (response.statusCode == 200) {
        ReportsResponseClass responseClass =
            ReportsResponseClass.fromJson(json.decode(response.body));
        for (int i = 0; i < responseClass.data!.length; i++) {
          list.add(responseClass.data![i]);
        }
        return list;
      } else {
        return Future.error("Fail");
      }
    } catch (e) {
      return Future.error("$e");
    }
  }

  Future<ReportsStatusResponseClass> changeReportStatus(
      Data data, String status) async {
    try {
      var headers = await Globals().createHeaders();

      var request = http.Request('PUT', Uri.parse('${Globals.apiUrl}/api/reports/updateReport?id=${data.sId}'));
      request.body = json.encode({
        "_id": data.sId,
        "client": data.client!.sId,
        "bank": data.bank!.sId,
        "uploader": data.uploader!.sId,
        "visitor": data.visitor!.sId,
        "status": status
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      //
      // final queryParameters = {
      //   "_id": data.sId,
      //   "client": data.client!.sId,
      //   "bank": data.bank!.sId,
      //   "uploader": data.uploader!.sId,
      //   "visitor": data.visitor!.sId,
      //   "status": status
      // };
      //
      // final uri = Uri.https("65.1.104.178",
      //     '/api/reports/updateReport?id=${data.sId}', queryParameters);
      // log("URI:- $uri");
      // var response = await http.post(
      //   uri,
      //   headers: headers,
      // );
      //
      // log("REPORT_STATUS_RESPONSE:- ${response.body}");

      if (response.statusCode == 200) {
        String response1 = await response.stream.bytesToString();
        ReportsStatusResponseClass responseClass =
            ReportsStatusResponseClass.fromJson(json.decode(response1));
        return responseClass;
      } else {
        return Future.error("Fail");
      }
    } catch (e) {
      log("REPORT_STATUS_EXCEPTION:- $e");
      return Future.error("$e");
    }
  }
}
