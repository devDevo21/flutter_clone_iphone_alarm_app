import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Alarm extends ChangeNotifier {
  Alarm({
    this.sonerie = 'audio/Morning-Glory.mp3',
    this.rapel = false,
    this.isActivated = true,
    this.repeatAlarmNumber = 2,
  }) {
    generateIdForAlarm();
    // sonnerieSetUp();
  }

  static int alarmCount = 0;
  int id = 0;
  TimeOfDay effectiveTime = TimeOfDay.now();
  String? description;
  String sonerie;
  String? alarme;
  bool rapel;
  bool isActivated;
  List recurence = [];
  late Timer timer;
  late Duration sonerieDuration;
  late AudioPlayer player;
  bool alarmIsCurrentPlaying = false;
  late Timer periodicTimer;
  int repeatAlarmNumber;

  Color get activateAlarmColor {
    return isActivated ? Colors.white : Colors.grey;
  }

  void generateIdForAlarm() {
    id = ++Alarm.alarmCount;
  }

  sonnerieSetUp() async {
    player = AudioPlayer();
    await player.setSourceAsset(sonerie);
    await player.getDuration().then((value) {
      if (value != null) {
        sonerieDuration = value;
      }
    });
  }

  void reveilleMoi() async {
    isActivated = true;
    await sonnerieSetUp();

    DateTime currentDate = DateTime.now();
    DateTime futureDate = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      effectiveTime.hour,
      effectiveTime.minute,
    );

    final int delay = futureDate.difference(currentDate).inMicroseconds;

    if (delay > 0) {
      triggerAlarmforFutureDate(delay);
    } else {
      triggerAlarmforPastDate(currentDate, futureDate);
    }
  }

  void sonner() async {
    alarmIsCurrentPlaying = true;
    int limitValue = repeatAlarmNumber;
    final nullDurationTimer = Timer(const Duration(microseconds: 0), () {
      player.play(AssetSource(sonerie));
    });

    void toDo(Timer timer) {
      nullDurationTimer.cancel();
      player.release();
      player.play(AssetSource(sonerie));
      limitValue--;
      if (limitValue == 0) {
        clearAlarm();
      }
    }

    periodicTimer = Timer.periodic(sonerieDuration, toDo);
  }

  clearAlarm() {
    timer.cancel();
    isActivated = false;
    if (alarmIsCurrentPlaying) {
      player.dispose();
      periodicTimer.cancel();
      alarmIsCurrentPlaying = false;
    }
    // notifyListeners();
  }

  void triggerAlarmforFutureDate(int delay) {
    alarmTimer(
      duree: Duration(microseconds: delay),
    );
  }

  void triggerAlarmforPastDate(DateTime currentDate, DateTime futureDate) {
    int currentTime =
        Duration(hours: currentDate.hour, minutes: currentDate.minute)
            .inSeconds;

    int futureTime =
        Duration(hours: futureDate.hour, minutes: futureDate.minute).inSeconds;

    int differenceDuration = currentTime - futureTime;

    int finalDuration = 3600 - differenceDuration;
    alarmTimer(duree: Duration(seconds: finalDuration));
  }

  void alarmTimer({required Duration duree}) {
    timer = Timer(duree, sonner);
  }
}



// class EmmetNotifier extends ConsumerWidget {

//   EmmetNotifier(){

//   }

//   desableNotifier([WidgetRef? ref]) {
//     if (ref != null) {
//       ref.watch(alarmProvider).toggleAlarm(0, false);
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // desableNotifier(ref);
//     print("dededdederfr............................");
//     return Container();
//   }
// }
