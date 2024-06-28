import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttter_alarm_app/audio_data/audio_data.dart';
import 'package:fluttter_alarm_app/models/alarm.dart';
import 'package:fluttter_alarm_app/provider/alarm_provider.dart';
import 'package:fluttter_alarm_app/views/alarm_view.dart';
// import 'package:google_fonts/google_fonts.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Alarm alarm = Alarm();
    String selectedConfType = '';

    Future<void> selectDate() async {
      TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      // hour: DateTime.now().hour+1 , minute:DateTime.now().minute
      if (result != null) {
        alarm.effectiveTime = result;
      }
    }

    void saveAlam() {
      if (selectedConfType != '') {
        alarm.sonerie = selectedConfType;
      }
      ref.watch(alarmProvider).addNewAlarm(alarm);
      alarm.reveilleMoi();
      Navigator.of(context).pop();
    }

    Future<void> showBottomSheetFunction() async {
      await showModalBottomSheet(
        // isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: const Color.fromARGB(255, 31, 31, 31),
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 0),
            width: double.infinity,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Annuler',
                      textScaler: TextScaler.linear(1.2),
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 136, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text('Nouv. alarme',
                      textScaler: TextScaler.linear(1.2),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: saveAlam,
                    child: const Text(
                      'Enregistrer',
                      textScaler: TextScaler.linear(1.2),
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 136, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 40),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            backgroundColor: Colors.white),
                        onPressed: selectDate,
                        child: const Text('Selectionnez une heure',
                            textScaler: TextScaler.linear(1.2),
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 136, 0),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  DropdownButtonFormField(
                      value: dropDownMenuItems.first.value,
                      items: dropDownMenuItems,
                      decoration: const InputDecoration(
                          label: Text('Selectionner une sonnerie',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 136, 0))),
                          contentPadding:
                              EdgeInsets.only(top: 10, left: 15, bottom: 10),
                          border: OutlineInputBorder()),
                      onChanged: (value) {
                        selectedConfType = value!;
                      }),
                  // const TextField(
                  //   decoration: InputDecoration(
                  //     label: Text('Description'),
                  //     border: OutlineInputBorder()
                  //   ),
                  // )
                ],
              )
            ]),
          );
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Modifier',
                    textScaler: TextScaler.linear(1.3),
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 136, 0),
                        fontFamily: 'Roboto'),
                  ),
                  IconButton(
                      onPressed: showBottomSheetFunction,
                      icon: const Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 255, 136, 0),
                        size: 25,
                      ))
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Alarmes',
                          // style: GoogleFonts.lato(
                          //   color: Colors.white,
                          //   fontWeight: FontWeight.bold,
                          //   fontSize: 35,
                          // ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 3),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: .3, color: Colors.grey))),
                        child: const Row(
                          children: [
                            Icon(
                              (Icons.bed),
                              color: Colors.white,
                            ),
                            Text(
                              ' Sommeil  |  Réveil',
                              textScaler: TextScaler.linear(1.3),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: .3, color: Colors.grey))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Aucune alarme',
                              textScaler: TextScaler.linear(1.1),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 28, 28, 28)),
                                  onPressed: () {},
                                  child: const Text(
                                    'CONFIGURER',
                                    textScaler: TextScaler.linear(1.1),
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 255, 136, 0),
                                        fontWeight: FontWeight.bold),
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 25, bottom: 5),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: .3, color: Colors.grey))),
                        child: const Row(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Autres',
                                  textScaler: TextScaler.linear(1.3),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ),
                      ...ref.read(alarmProvider).alarmList.map((alarm) {
                        return AlarmW(alarm: alarm, id: alarm.id);
                      }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   elevation: 50,
        //   onTap: (v) {},
        //   currentIndex: 0,
        //   selectedItemColor: const Color.fromARGB(255, 255, 136, 0),
        //   unselectedItemColor: Colors.grey,
        //   backgroundColor: Theme.of(context).primaryColor,
        //   items: const [
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.alarm),
        //         label: 'Alarme',
        //         backgroundColor: Colors.black),
        //     BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Horloge'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.alarm), label: 'Chronometre'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.alarm), label: 'Minuteurs'),
        //   ],
        // ),
      ),
    );
  }
}
