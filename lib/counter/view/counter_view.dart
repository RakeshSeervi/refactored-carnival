import 'package:bloc_counter/counter/bloc/counter_bloc.dart'
    as ProperBlocStructure;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        // child: BlocBuilder<CounterBloc, int>(
        // child: BlocBuilder<CounterCubit, int>(
        child: BlocBuilder<ProperBlocStructure.CounterBloc,
            ProperBlocStructure.CounterState>(
          builder: (context, state) => Text(
            '${state.count}',
            style: textTheme.headline2,
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              key: const Key('counterView_increment_floatingActionButton'),
              child: const Icon(Icons.add),
              onPressed: () =>
                  // context.read<CounterBloc>().add(CounterEvent.increment),
                  // context.read<CounterCubit>().increment()
                  context
                      .read<ProperBlocStructure.CounterBloc>()
                      .add(ProperBlocStructure.CounterIncremented())),
          FloatingActionButton(
              key: const Key('counterView_decrement_floatingActionButton'),
              child: Icon(Icons.remove),
              onPressed: () =>
                  // context.read<CounterBloc>().add(CounterEvent.decrement),
                  // context.read<CounterCubit>().decrement()
                  context
                      .read<ProperBlocStructure.CounterBloc>()
                      .add(ProperBlocStructure.CounterDecremented()))
        ],
      ),
    );
  }
}
