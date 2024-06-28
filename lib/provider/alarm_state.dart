import 'package:flutter/material.dart';
import 'package:fluttter_alarm_app/models/alarm.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AlarmState extends ChangeNotifier {
  List<Alarm> alarmList = [];

  addNewAlarm(Alarm alarm) {
    alarmList.add(alarm);
    notifyListeners();
  }

  void deleteAlarm({required int id}) {
    alarmList.removeWhere((alarm) => alarm.id == id);
    // pas de notifyListeners() car on ne souhaite pas appliquer les modifications instantanément (pas de nouveau rendu)
  }

  void toggleAlarm(int id, bool state) {
    Alarm alarm = alarmList.firstWhere((alarm) => alarm.id == id);
    if (state) {
      alarm.reveilleMoi();
    } else {
      alarm.clearAlarm();
    }
    notifyListeners();
  }
}
