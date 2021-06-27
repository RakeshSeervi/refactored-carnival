import 'package:bloc_counter/khushi/appointments/bloc/appointments_bloc.dart';
import 'package:bloc_counter/khushi/appointments/view/appointments_view.dart';
import 'package:bloc_counter/khushi/constants.dart';
import 'package:bloc_counter/khushi/widgets/custom_app_bar.dart';
import 'package:bloc_counter/khushi/widgets/custom_back_button.dart';
import 'package:bloc_counter/khushi/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              leading: CustomBackButton(),
              title: const Text(
                "Add Appointment",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  32.0,
                  16.0,
                  32.0,
                  32.0,
                ),
                child: Form(
                  autovalidateMode: _autovalidateMode,
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 12.0,
                        ),
                        child: Text(
                          'Title',
                          style: labelStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 24.0,
                        ),
                        child: TextFormField(
                          autofocus: true,
                          controller: titleController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Gastrointerstinal disease',
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Title cannot be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 12.0,
                        ),
                        child: Text(
                          'About',
                          style: labelStyle,
                        ),
                      ),
                      TextFormField(
                        controller: aboutController,
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                        minLines: 3,
                        maxLines: 15,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'lorem ipsum',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter some description';
                          }
                          return null;
                        },
                      ),
                      Spacer(),
                      GradientButton(
                        label: 'Save Appointment',
                        onPressed: () {
                          setState(() {
                            _autovalidateMode = AutovalidateMode.always;
                          });
                          if (_formKey.currentState!.validate()) {
                            context.read<AppointmentsBloc>().add(
                                  AppointmentAdded(
                                    appointment: Appointment(
                                      dateTime: args['dateTime'],
                                      patient: args['patient'],
                                      title: titleController.text,
                                      about: aboutController.text,
                                    ),
                                  ),
                                );
                            Navigator.of(context).popUntil(ModalRoute.withName(
                                AppointmentsView.routeName));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
