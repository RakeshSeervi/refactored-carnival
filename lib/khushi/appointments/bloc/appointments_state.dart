part of 'appointments_bloc.dart';

class AppointmentsState extends Equatable {
  final LinkedHashMap<DateTime, List<Appointment>> appointments;

  const AppointmentsState({required this.appointments});

  @override
  String toString() => appointments.toString();

  @override
  List<Object?> get props => [appointments];
}
