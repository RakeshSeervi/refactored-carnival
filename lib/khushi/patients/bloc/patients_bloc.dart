import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_counter/khushi/patients/patient.dart';
import 'package:bloc_counter/khushi/patients/patients.dart';
import 'package:equatable/equatable.dart';

part 'patients_event.dart';

part 'patients_state.dart';

class PatientsBloc extends Bloc<PatientsEvent, PatientsState> {
  PatientsBloc() : super(PatientsInitial());

  @override
  Stream<PatientsState> mapEventToState(
    PatientsEvent event,
  ) async* {}
}
