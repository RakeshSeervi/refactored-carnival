import 'package:bloc_counter/khushi/appointments/view/select_date_time.dart';
import 'package:bloc_counter/khushi/constants.dart';
import 'package:bloc_counter/khushi/patients/bloc/patients_bloc.dart';
import 'package:bloc_counter/khushi/patients/patient.dart';
import 'package:bloc_counter/khushi/widgets/custom_app_bar.dart';
import 'package:bloc_counter/khushi/widgets/custom_back_button.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              leading: CustomBackButton(),
              title: const Text(
                "Choose Patient",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
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
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  28.0,
                  14.0,
                  28.0,
                  28.0,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF8F9FA),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            borderSide: BorderSide(
                              color: Color(0xFFD0D3D7),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
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
                            child: ListView.builder(
                              itemCount: patients.length,
                              itemBuilder: (context, index) =>
                                  PatientTile(patient: patients[index]),
                            ),
                          )
                        : Center(
                            child: Text('No results found!'),
                          ),
                  ],
                ),
              ),
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
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: InkWell(
        splashColor: Color(0xFFCCD2D6),
        onTap: () {
          Navigator.of(context).pushNamed(SelectDateTime.routeName, arguments: {
            'patient': patient,
          });
        },
        child: Container(
          height: 32.0,
          alignment: Alignment.centerLeft,
          child: Text(
            patient.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
