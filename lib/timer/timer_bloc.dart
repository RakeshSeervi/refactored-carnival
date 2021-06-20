import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

enum TimerEvent { TimerStarted, TimerPaused, TimerReset }

class TimerBloc extends Bloc {
  TimerBloc() : super(60);

  Stream<int> decrement() async* {
    while (state > 0) {
      yield state - 1 as int;
      Future.delayed(Duration(seconds: 1));
    }
  }

  late StreamSubscription s;

  @override
  Stream<int> mapEventToState(event) async* {
    switch (event) {
      case TimerEvent.TimerStarted:
        // s = decrement().listen((event) { yield state-1; });
        break;
      case TimerEvent.TimerPaused:
        s.cancel();
    }
  }
}
