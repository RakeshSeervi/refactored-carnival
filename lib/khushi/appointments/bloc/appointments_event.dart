part of 'appointments_bloc.dart';

abstract class AppointmentsEvent extends Equatable {
  const AppointmentsEvent();
}

class AppointmentAdded extends AppointmentsEvent {
  final Appointment appointment;

  const AppointmentAdded({required this.appointment}) : super();

  @override
  List<Object?> get props => [appointment];
}
