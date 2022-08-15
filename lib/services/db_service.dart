import 'dart:convert';

import 'package:alarm_clock_task/models/alarm_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class DBService {
  static const String dbName = "db_notes";
  static Box box = Hive.box(dbName);

  static Future<void> storeAlarms(List<Alarm> noteList) async {
    // object => map => String
    List<String> stringList = noteList.map((alarm) => jsonEncode(alarm.toJson())).toList();
    await box.put("notes", stringList);
  }

  static List<Alarm> loadAlarms() {
    // String =>  Map => Object
    List<String> stringList = box.get("notes") ?? <String>[];
    List<Alarm> noteList = stringList.map((string) => Alarm.fromJson(jsonDecode(string))).toList();
    return noteList;
  }
}