import 'dart:async';
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<String> getUsername() async {
    var box = Hive.box('token');
    var token = box.get('user');
    var res = jsonDecode(token);
    return res['username'];
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    var box = Hive.box('token');
    box.clear();
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    var box = Hive.box('token');
    box.put('user', token);
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    var box = Hive.box('token');
    var token = box.get('user');
    if (token != null) {
      return true;
    }
    return false;
  }
}
