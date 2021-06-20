import 'package:bloc_counter/counter/view/counter_page.dart';
import 'package:flutter/material.dart';

class CounterApp extends MaterialApp {
  const CounterApp({Key? key})
      : super(key: key, title: 'lorem ipsum', home: const CounterPage());
}
