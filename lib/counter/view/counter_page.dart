import 'package:bloc_counter/counter/bloc/counter_bloc.dart'
    as ProperBlocStructure;
import 'package:bloc_counter/counter/view/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // create: (_) => CounterBloc(),
      // create: (_) => CounterCubit(),
      create: (_) => ProperBlocStructure.CounterBloc(),
      child: CounterView(),
    );
  }
}
