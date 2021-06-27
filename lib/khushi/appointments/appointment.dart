import 'package:bloc_counter/khushi/patients/patient.dart';

class Appointment {
  final Patient patient;
  final DateTime dateTime;
  final String title;
  final String about;

  const Appointment({
    required this.dateTime,
    required this.patient,
    required this.title,
    required this.about,
  });

  @override
  String toString() {
    return 'Patient: ${patient.name} has an appointment on ${dateTime.toString()}';
  }
}
