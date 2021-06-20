part of 'patients_bloc.dart';

abstract class PatientsState extends Equatable {
  final List<Patient> patients;

  const PatientsState({required this.patients});

  @override
  List<Object?> get props => [patients];
}

class PatientsInitial extends PatientsState {
  const PatientsInitial() : super(patients: patients);
}
