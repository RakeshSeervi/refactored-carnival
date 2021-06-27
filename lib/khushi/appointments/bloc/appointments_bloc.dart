import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:bloc_counter/khushi/appointments/appointment.dart';
import 'package:bloc_counter/khushi/appointments/appointments.dart';
import 'package:equatable/equatable.dart';
import 'package:table_calendar/table_calendar.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  AppointmentsBloc() : super(AppointmentsState(appointments: appointments));

  @override
  Stream<AppointmentsState> mapEventToState(
    AppointmentsEvent event,
  ) async* {
    if (event is AppointmentAdded) {
      yield* _mapAppointmentAddedToState(event);
    }
  }

  Stream<AppointmentsState> _mapAppointmentAddedToState(
      AppointmentAdded event) async* {
    LinkedHashMap<DateTime, List<Appointment>> appointments = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(state.appointments);
    if (appointments.containsKey(event.appointment.dateTime))
      appointments[event.appointment.dateTime]!.add(event.appointment);
    else
      appointments[event.appointment.dateTime] = [event.appointment];
    yield AppointmentsState(appointments: appointments);
  }
}
