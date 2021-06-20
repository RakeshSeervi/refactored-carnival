import 'package:bloc_counter/khushi/appointments/bloc/appointments_bloc.dart';
import 'package:bloc_counter/khushi/appointments/view/appointments_view.dart';
import 'package:bloc_counter/khushi/constants.dart';
import 'package:bloc_counter/khushi/patients/patient.dart';
import 'package:bloc_counter/khushi/widgets/back_button.dart';
import 'package:bloc_counter/khushi/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../appointment.dart';

class AddAppointmentForm extends StatefulWidget {
  static const String routeName = '/addAppointment';

  @override
  _AddAppointmentFormState createState() => _AddAppointmentFormState();
}

class _AddAppointmentFormState extends State<AddAppointmentForm> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final aboutController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    titleController.dispose();
    aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Patient p = ModalRoute.of(context)!.settings.arguments as Patient;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: Colors.white,
        leading: CustomBackButton(),
        titleSpacing: 0,
        title: const Text(
          "Add Appointment",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(28, 14, 28, 28),
        child: Form(
          autovalidateMode: _autovalidateMode,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Title',
                  style: labelStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  autofocus: true,
                  controller: titleController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Gastrointerstinal disease'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'About',
                  style: labelStyle,
                ),
              ),
              TextFormField(
                  controller: aboutController,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  minLines: 5,
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'lorem ipsum',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  }),
              Spacer(
                flex: 1,
              ),
              GradientButton(
                label: 'Save Appointment',
                onPressed: () {
                  setState(() {
                    _autovalidateMode = AutovalidateMode.always;
                  });
                  if (_formKey.currentState!.validate()) {
                    context.read<AppointmentsBloc>().add(
                          AddAppointment(
                            appointment: Appointment(
                                dateTime:
                                    DateTime.now().add(Duration(hours: 2)),
                                patient: p,
                                title: titleController.text,
                                about: aboutController.text),
                          ),
                        );
                    Navigator.of(context).popUntil(
                        ModalRoute.withName(AppointmentsView.routeName));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
