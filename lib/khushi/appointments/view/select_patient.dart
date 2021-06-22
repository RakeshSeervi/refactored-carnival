import 'package:bloc_counter/khushi/appointments/view/select_date_time.dart';
import 'package:bloc_counter/khushi/constants.dart';
import 'package:bloc_counter/khushi/patients/bloc/patients_bloc.dart';
import 'package:bloc_counter/khushi/patients/patient.dart';
import 'package:bloc_counter/khushi/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectPatient extends StatefulWidget {
  static const String routeName = '/selectPatient';

  const SelectPatient({Key? key}) : super(key: key);

  @override
  _SelectPatientState createState() => _SelectPatientState();
}

class _SelectPatientState extends State<SelectPatient> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    var patients = context
        .select((PatientsBloc bloc) => bloc.state.patients)
        .where((p) => p.name.toLowerCase().startsWith(searchText.toLowerCase()))
        .toList()
          ..sort((p1, p2) => p1.name.compareTo(p2.name));

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: Colors.white,
        leading: CustomBackButton(),
        titleSpacing: 0,
        title: const Text(
          "Choose Patient",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              '+ Add Patient',
              style: TextStyle(
                color: secondaryColor,
              ),
            ),
          )
        ],
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(28, 14, 28, 28),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF8F9FA),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFD0D3D7),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFD0D3D7),
                    ),
                  ),
                  hintText: 'Search for a patient',
                  hintStyle: TextStyle(
                    color: Color(0xFFAFB7C2),
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color(0xFFD0D3D7),
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    searchText = val;
                  });
                },
              ),
            ),
            patients.length > 0
                ? Expanded(
                    child: ListView(
                      children: [
                        for (Patient patient in patients)
                          PatientTile(patient: patient)
                      ],
                    ),
                  )
                : Center(
                    child: Text('No results found!'),
                  ),
          ],
        ),
      ),
    );
  }
}

class PatientTile extends StatelessWidget {
  const PatientTile({
    Key? key,
    required this.patient,
  }) : super(key: key);

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(SelectDateTime.routeName, arguments: {
            'patient': patient,
          });
        },
        child: Text(
          patient.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
