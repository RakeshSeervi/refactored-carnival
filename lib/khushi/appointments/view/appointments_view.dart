import 'package:bloc_counter/khushi/appointments/appointment.dart';
import 'package:bloc_counter/khushi/appointments/bloc/appointments_bloc.dart';
import 'package:bloc_counter/khushi/appointments/view/select_patient.dart';
import 'package:bloc_counter/khushi/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants.dart';

class AppointmentsView extends StatefulWidget {
  static const String routeName = '/appointments';

  const AppointmentsView({Key? key}) : super(key: key);

  @override
  _AppointmentsViewState createState() => _AppointmentsViewState();
}

class _AppointmentsViewState extends State<AppointmentsView> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    _selectedDay = _focusedDay;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        iconTheme: IconThemeData(
          size: 24,
          color: Color(0xFFD0D3D7),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.account_circle_outlined,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.chat_bubble_outline,
            ),
          )
        ],
      ),
      body: BlocBuilder<AppointmentsBloc, AppointmentsState>(
        builder: (context, state) {
          var upcoming = [];
          var completed = [];
          for (Appointment apt in state.appointments[_selectedDay] ?? [])
            if (apt.dateTime.compareTo(DateTime.now()) >= 0)
              upcoming.add(apt);
            else
              completed.add(apt);
          upcoming.sort((a, b) => a.dateTime.compareTo(b.dateTime));
          completed.sort((a, b) => a.dateTime.compareTo(b.dateTime));

          return Padding(
            padding:
                const EdgeInsets.only(left: 28.0, right: 28.0, bottom: 28.0),
            child: Column(
              children: [
                TableCalendar(
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2021),
                  lastDay: DateTime(2022),
                  calendarFormat: CalendarFormat.week,
                  availableCalendarFormats: {
                    CalendarFormat.week: 'Week',
                  },
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay =
                          focusedDay; // update `_focusedDay` here as well
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  eventLoader: (day) {
                    return state.appointments[day] ?? [];
                  },
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    weekendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  calendarBuilders:
                      CalendarBuilders(selectedBuilder: (_, d1, d2) {
                    return Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                accentColor,
                                secondaryColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )),
                        child: Text(
                          d1.day.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ListView(
                      children: [
                        if (upcoming.length > 0) ...[
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 8.0),
                            child: Text(
                              'Upcoming Appointments',
                              style: TextStyle(
                                color: Color(0xFFAFB7C2),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          for (Appointment appointment in upcoming)
                            AppointmentContainer(appointment: appointment),
                        ],
                        if (completed.length > 0) ...[
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 8.0),
                            child: Text(
                              'Completed Appointments',
                              style: TextStyle(
                                color: Color(0xFFAFB7C2),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          for (Appointment appointment in completed)
                            AppointmentContainer(appointment: appointment),
                        ],
                      ],
                    ),
                  ),
                ),
                GradientButton(
                  label: '+ Add Appointment',
                  onPressed: () =>
                      Navigator.of(context).pushNamed(SelectPatient.routeName),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class AppointmentContainer extends StatelessWidget {
  const AppointmentContainer({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFFD0D3D7),
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                appointment.patient.name + '  •  ₹700 due',
                style: TextStyle(
                  color: Color(0xFFAFB7C2),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  DateFormat("h:mma")
                      .format(appointment.dateTime)
                      .toLowerCase(),
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 1,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Color(0xFFD0D3D7),
                    ),
                  ),
                ),
                Text(
                  appointment.title,
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentTile extends StatelessWidget {
  const AppointmentTile({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color(0xFFD0D3D7),
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        title: Text(
          appointment.patient.name + '  •  ₹700 due',
          style: TextStyle(
            color: Color(0xFFAFB7C2),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              DateFormat("h:mma").format(appointment.dateTime),
              style: TextStyle(
                color: Color(0xFF1A1A1A),
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: 1,
                height: 16,
                decoration: BoxDecoration(
                  color: Color(0xFFD0D3D7),
                ),
              ),
            ),
            Text(
              appointment.title,
              style: TextStyle(
                color: Color(0xFF1A1A1A),
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
