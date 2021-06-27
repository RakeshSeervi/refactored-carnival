import 'package:bloc_counter/khushi/appointments/view/add_appointment.dart';
import 'package:bloc_counter/khushi/widgets/custom_app_bar.dart';
import 'package:bloc_counter/khushi/widgets/custom_back_button.dart';
import 'package:bloc_counter/khushi/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants.dart';

class SelectDateTime extends StatefulWidget {
  static const String routeName = '/selectDateTime';

  const SelectDateTime({Key? key}) : super(key: key);

  @override
  _SelectDateTimeState createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends State<SelectDateTime> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String period = DateFormat('a').format(DateTime.now());
  String _hourErrorMessage = '';
  String _minutesErrorMessage = '';

  final _formKey = GlobalKey<FormState>();
  final hourController = TextEditingController();
  final minutesController = TextEditingController();

  late FocusNode hourFocusNode;
  late FocusNode minutesFocusNode;

  @override
  void initState() {
    _selectedDay = _focusedDay;
    hourFocusNode = FocusNode();
    minutesFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    hourFocusNode.dispose();
    minutesFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              leading: CustomBackButton(),
              title: Text(
                'Choose Date and Time',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2021),
              lastDay: DateTime.utc(2022),
              availableCalendarFormats: {
                CalendarFormat.month: 'Month',
              },
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
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
              calendarBuilders: CalendarBuilders(
                dowBuilder: (_, date) {
                  return Center(
                    child: Text(
                      DateFormat.E().format(date)[0],
                      style: TextStyle(
                        color: Color(0xFFAFB7C2),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                selectedBuilder: (_, d1, d2) {
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
                          )),
                      child: Text(
                        d1.day.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
                todayBuilder: (_, d1, d2) {
                  return Center(
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFCCD2D6)),
                      child: Text(
                        d1.day.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
              headerStyle: HeaderStyle(
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                headerPadding: EdgeInsets.symmetric(
                  vertical: 16.0,
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
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
              ),
              child: Divider(
                color: Color(0xFFD0D3D7),
                thickness: 1,
              ),
            ),
            Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40.0,
                    child: TextFormField(
                      controller: hourController,
                      keyboardType: TextInputType.number,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      maxLength: 2,
                      textAlign: TextAlign.center,
                      focusNode: hourFocusNode,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: 'hh',
                        errorStyle: TextStyle(
                          height: 0.0,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        final hours = int.tryParse(value);
                        if (hours != null && hours > 1) {
                          hourFocusNode.unfocus();
                          minutesFocusNode.requestFocus();
                        }
                      },
                      validator: (value) {
                        final hours = int.tryParse(value ?? '');
                        _hourErrorMessage = '';
                        if (value == null ||
                            hours == null ||
                            hours < 1 ||
                            hours > 12)
                          _hourErrorMessage = 'Hours should range from 1 to 12';

                        return _hourErrorMessage == ''
                            ? null
                            : _hourErrorMessage;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Text(
                      ':',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40.0,
                    child: TextFormField(
                      controller: minutesController,
                      keyboardType: TextInputType.number,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      maxLength: 2,
                      textAlign: TextAlign.center,
                      focusNode: minutesFocusNode,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: 'mm',
                        errorStyle: TextStyle(
                          height: 0.0,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.length == 2) minutesFocusNode.unfocus();
                      },
                      validator: (value) {
                        final minutes = int.tryParse(value ?? '');
                        _minutesErrorMessage = '';
                        if (value == null ||
                            minutes == null ||
                            minutes < 0 ||
                            minutes > 59)
                          _minutesErrorMessage =
                              'Minutes should range from 1 to 59';

                        return _minutesErrorMessage == ''
                            ? null
                            : _minutesErrorMessage;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 16.0,
                          width: 32.0,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                period = 'AM';
                              });
                            },
                            style: ButtonStyle(
                              visualDensity: VisualDensity.compact,
                              minimumSize: MaterialStateProperty.all(Size.zero),
                            ),
                            child: Text(
                              'AM',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: period == 'AM'
                                    ? Colors.black
                                    : Color(0xFFAFB7C2),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                          width: 32.0,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                period = 'PM';
                              });
                            },
                            style: ButtonStyle(
                              visualDensity: VisualDensity.compact,
                              minimumSize: MaterialStateProperty.all(Size.zero),
                            ),
                            child: Text(
                              'PM',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: period == 'PM'
                                    ? Colors.black
                                    : Color(0xFFAFB7C2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            if ((_hourErrorMessage + _minutesErrorMessage).length > 0)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Text(
                  _hourErrorMessage + '\n' + _minutesErrorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            Spacer(),
            Text(
              'Past appointments can also be added.',
              style: TextStyle(
                color: Color(0xFFAFB7C2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                28,
                16,
                28,
                28,
              ),
              child: GradientButton(
                label: 'Continue',
                onPressed: () {
                  setState(() {
                    _autovalidateMode = AutovalidateMode.always;
                  });
                  if (_formKey.currentState!.validate())
                    Navigator.of(context)
                        .pushNamed(AddAppointmentForm.routeName, arguments: {
                      'patient': args['patient'],
                      'dateTime': DateTime(
                          _selectedDay!.year,
                          _selectedDay!.month,
                          _selectedDay!.day,
                          int.parse(hourController.text) +
                              (period == 'AM' ? 0 : 12),
                          int.parse(minutesController.text))
                    });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
