import 'package:bloc_counter/khushi/appointments/appointment.dart';
import 'package:bloc_counter/khushi/appointments/bloc/appointments_bloc.dart';
import 'package:bloc_counter/khushi/appointments/view/select_patient.dart';
import 'package:bloc_counter/khushi/widgets/custom_app_bar.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: Color(0xFFD0D3D7),
                ),
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Color(0xFFD0D3D7),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    color: Color(0xFFD0D3D7),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 28.0,
                  right: 28.0,
                  bottom: 28.0,
                ),
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
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
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
                      calendarStyle: CalendarStyle(
                        defaultTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        weekendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      calendarBuilders: CalendarBuilders(dowBuilder: (_, date) {
                        return Center(
                          child: Text(
                            DateFormat.E().format(date)[0],
                            style: TextStyle(
                              color: Color(0xFFAFB7C2),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }, selectedBuilder: (_, d1, d2) {
                        return Center(
                          child: Container(
                            height: 40.0,
                            width: 40.0,
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
                              ),
                            ),
                            child: Text(
                              d1.day.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }, todayBuilder: (_, d1, d2) {
                        return Center(
                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFCCD2D6)),
                            child: Text(
                              d1.day.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }),
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                        rightChevronMargin: EdgeInsets.all(
                          0.0,
                        ),
                        leftChevronIcon: Icon(
                          Icons.arrow_back_ios,
                          color: accentColor,
                        ),
                        rightChevronIcon: Icon(
                          Icons.arrow_forward_ios,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: BlocBuilder<AppointmentsBloc, AppointmentsState>(
                          builder: (context, state) {
                            List<Widget> appointments = [];
                            List<Appointment> upcoming = [];
                            List<Appointment> completed = [];
                            for (Appointment appointment
                                in state.appointments[_selectedDay] ?? [])
                              if (appointment.dateTime
                                      .compareTo(DateTime.now()) >=
                                  0)
                                upcoming.add(appointment);
                              else
                                completed.add(appointment);
                            upcoming.sort(
                                (a, b) => a.dateTime.compareTo(b.dateTime));
                            completed.sort(
                                (a, b) => a.dateTime.compareTo(b.dateTime));

                            if (upcoming.length > 0) {
                              appointments.add(Header(
                                heading: 'Upcoming Appointments',
                              ));
                              appointments.addAll(upcoming.map((appointment) =>
                                  AppointmentContainer(
                                      appointment: appointment)));
                            }
                            if (completed.length > 0) {
                              appointments.add(Header(
                                heading: 'Completed Appointments',
                              ));
                              appointments.addAll(completed.map((appointment) =>
                                  AppointmentContainer(
                                      appointment: appointment)));
                            }
                            return ListView.builder(
                              itemCount: appointments.length,
                              itemBuilder: (context, index) {
                                return appointments[index];
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    GradientButton(
                      label: '+ Add Appointment',
                      onPressed: () => Navigator.of(context)
                          .pushNamed(SelectPatient.routeName),
                    )
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

class Header extends StatelessWidget {
  final heading;

  const Header({
    Key? key,
    required this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        bottom: 8.0,
      ),
      child: Text(
        heading,
        style: TextStyle(
          color: Color(0xFFAFB7C2),
          fontWeight: FontWeight.w600,
        ),
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
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Container(
        padding: EdgeInsets.all(
          16.0,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFD0D3D7),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              8.0,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8.0,
              ),
              child: Text(
                appointment.patient.name + '  •  ₹700 due',
                style: TextStyle(
                  color: Color(0xFFAFB7C2),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
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

// can be used in place of AppointmentContainer
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
