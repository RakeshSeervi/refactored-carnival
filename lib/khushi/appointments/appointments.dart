import 'dart:collection';

import 'package:bloc_counter/khushi/appointments/appointment.dart';
import 'package:bloc_counter/khushi/patients/patient.dart';
import 'package:table_calendar/table_calendar.dart';

final LinkedHashMap<DateTime, List<Appointment>> appointments =
    LinkedHashMap(equals: isSameDay, hashCode: getHashCode)
      ..addAll({
        DateTime.now(): [
          Appointment(
              dateTime: DateTime.now(),
              patient: Patient(
                name: "Rakesh",
              ),
              title: 'Gastrointestinal Disease',
              about: 'lorem ipsum'),
        ],
        DateTime.utc(2021, 6, 6): [
          Appointment(
              dateTime: DateTime.utc(2021, 6, 6),
              patient: Patient(
                name: "Goutam",
              ),
              title: 'Abdominal pain diagnosis',
              about: 'lorem ipsum'),
        ],
        DateTime.utc(2021, 5, 5): [
          Appointment(
              dateTime: DateTime.utc(2021, 5, 5),
              patient: Patient(
                name: "Lalith",
              ),
              title: 'Gastrointestinal Disease',
              about: 'lorem ipsum'),
        ],
      });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
