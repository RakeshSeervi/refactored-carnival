import 'package:bloc_counter/khushi/appointments/bloc/appointments_bloc.dart';
import 'package:bloc_counter/khushi/appointments/view/add_appointment.dart';
import 'package:bloc_counter/khushi/appointments/view/appointments_view.dart';
import 'package:bloc_counter/khushi/appointments/view/select_patient.dart';
import 'package:bloc_counter/khushi/constants.dart';
import 'package:bloc_counter/khushi/patients/bloc/patients_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Khushi extends StatelessWidget {
  const Khushi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppointmentsBloc>(
          create: (BuildContext context) => AppointmentsBloc(),
        ),
        BlocProvider<PatientsBloc>(
          create: (BuildContext context) => PatientsBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Khushi",
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
          primaryColor: primaryColor,
          accentColor: accentColor,
        ),
        routes: {
          AppointmentsView.routeName: (_) => AppointmentsView(),
          AddAppointmentForm.routeName: (_) => AddAppointmentForm(),
          SelectPatient.routeName: (_) => SelectPatient(),
        },
        initialRoute: AppointmentsView.routeName,
      ),
    );
  }
}
