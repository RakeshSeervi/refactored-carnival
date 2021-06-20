import 'package:bloc_counter/khushi/khushi.dart';
import 'package:bloc_counter/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(Khushi());
}
