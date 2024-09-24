import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_pitfall_example/infrastructure/native_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'pitfall_event.dart';
part 'pitfall_state.dart';

class PitfallBloc extends Bloc<PitfallEvent, PitfallState> {
  PitfallBloc() : super(const PitfallBlocInitial()) {
    on<PitfallActionEvent>(
      _onPitfallActionEvent,
      transformer: sequential(),
    );
  }

  FutureOr<void> _onPitfallActionEvent(
      event, Emitter<PitfallState> emit) async {
    // because TimeoutException can be called
    if (event.actionNetwork) {
      await Future.delayed(
        const Duration(minutes: 1), // Simulate a long delay
        () async {
          final response = await http.get(Uri.parse('https://www.google.com/'));
          return response.body;
        },
      );
    }

    if (event.actionNativeCall) {
      if (event.withTimeOut) {
        await NativeService().getNativeData().timeout(
          const Duration(seconds: 3),
          onTimeout: () {
            return 'empty';
            // Timed out...
          },
        );
      } else {
        await NativeService().getNativeData();
      }
    }
    emit(PitfallBlocState(state.value + 1));
  }
}
