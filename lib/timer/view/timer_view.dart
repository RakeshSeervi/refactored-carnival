import 'package:bloc_counter/timer/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TimerText(),
          BlocBuilder<TimerBloc, TimerState>(
            buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
            builder: (_, state) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (state is TimerRunInProgress || state is TimerPause) ...[
                  FloatingActionButton(
                      child: state is TimerRunInProgress
                          ? Icon(Icons.pause)
                          : Icon(Icons.play_arrow),
                      onPressed: () {
                        state is TimerPause
                            ? context.read<TimerBloc>().add(TimerResumed())
                            : context.read<TimerBloc>().add(TimerPaused());
                      })
                ],
                FloatingActionButton(
                    child: state is TimerInitial
                        ? Icon(Icons.play_arrow)
                        : Icon(Icons.replay),
                    onPressed: () {
                      state is TimerInitial
                          ? context
                              .read<TimerBloc>()
                              .add(TimerStarted(duration: 60))
                          : context.read<TimerBloc>().add(TimerReset());
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      '$minutesStr:$secondsStr',
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
