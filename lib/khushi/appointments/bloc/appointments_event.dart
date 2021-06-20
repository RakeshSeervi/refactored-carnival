part of 'appointments_bloc.dart';

abstract class AppointmentsEvent extends Equatable {
  const AppointmentsEvent();
}

class AddAppointment extends AppointmentsEvent {
  final Appointment appointment;

  const AddAppointment({required this.appointment}) : super();

  @override
  List<Object?> get props => [appointment];
}
