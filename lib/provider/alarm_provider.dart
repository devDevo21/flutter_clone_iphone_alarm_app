import 'package:fluttter_alarm_app/provider/alarm_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final alarmProvider = ChangeNotifierProvider((ref) => AlarmState()) ;