import 'package:flutter/material.dart';

class DateTimeFormatter {

  static String formatDateTime(DateTime dateTime) {
    return "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  static String timeToJson(TimeOfDay timeOfDay) {
    return "${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}";
  }

  static TimeOfDay jsonToTime(String json) {
    final splitedJson = json.split(":");
    return TimeOfDay(hour: int.parse(splitedJson[0]), minute: int.parse(splitedJson[1]));
  }

}