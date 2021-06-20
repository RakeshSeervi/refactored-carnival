import 'package:bloc_counter/timer/view/timer_page.dart';
import 'package:flutter/material.dart';

class TimerApp extends MaterialApp {
  const TimerApp({Key? key})
      : super(
          key: key,
          title: 'lorem ipsum',
          home: const TimerPage(),
        );
}
