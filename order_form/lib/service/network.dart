import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

Future<http.Response> postRequest(data) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.mobile &&
      connectivityResult != ConnectivityResult.wifi) {
    AlertDialog(
        title: const Text("Network error"),
        content: const Text("No Internetconnection"),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {},
          )
        ]);
    throw ("Error");
  } else {
    var url = Uri.parse("https://www.mygrab.at/out.php");

    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    if (kDebugMode) {
      print("${response.statusCode}");
      print(response.body);
    }
    return response;
  }
}
