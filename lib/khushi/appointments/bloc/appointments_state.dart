part of 'appointments_bloc.dart';

class AppointmentsState {
  final LinkedHashMap<DateTime, List<Appointment>> appointments;

  const AppointmentsState({required this.appointments});

  List<Object?> get props => [appointments];

  @override
  String toString() => appointments.toString();
}
