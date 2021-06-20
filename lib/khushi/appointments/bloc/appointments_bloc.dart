import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:bloc_counter/khushi/appointments/appointment.dart';
import 'package:bloc_counter/khushi/appointments/appointments.dart';
import 'package:equatable/equatable.dart';

part 'appointments_event.dart';

part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  AppointmentsBloc() : super(AppointmentsState(appointments: appointments));

  @override
  Stream<AppointmentsState> mapEventToState(
    AppointmentsEvent event,
  ) async* {
    if (event is AddAppointment) {
      if (state.appointments.containsKey(event.appointment.dateTime))
        state.appointments[event.appointment.dateTime]!.add(event.appointment);
      else
        state.appointments[event.appointment.dateTime] = [event.appointment];
      yield AppointmentsState(appointments: state.appointments);
    }
  }
}
