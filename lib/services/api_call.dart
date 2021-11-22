import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/constants.dart';

final uid = FirebaseAuth.instance.currentUser?.uid;

Future<String> getBalance() async {
  print(apiUrl + '/api/getBalance?uid=' + uid!);
  final response =
      await http.get(Uri.parse(apiUrl + '/api/getBalance?uid=' + uid!));

  if (response.statusCode == 200) {
    final Map parsed = json.decode(response.body);
    return parsed['result'];
  } else {
    print(response.body);
    return "";
  }
}

Future login() async {
  final response = await http.get(Uri.parse(apiUrl + '/api/login?uid=' + uid!));

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print(response.body);
  }
}

Future<String> getAddress() async {
  final response =
      await http.get(Uri.parse(apiUrl + '/api/address?uid=' + uid!));

  if (response.statusCode == 200) {
    final Map parsed = json.decode(response.body);
    return parsed['result'];
  } else {
    print(response.body);
    return "";
  }
}
