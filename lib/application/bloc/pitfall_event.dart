part of 'pitfall_bloc.dart';

@immutable
abstract class PitfallEvent {}

@immutable
class PitfallActionEvent extends PitfallEvent {
  final bool actionNetwork;
  final bool actionNativeCall;
  final bool withTimeOut;

  PitfallActionEvent({
    this.actionNetwork = false,
    this.actionNativeCall = false,
    this.withTimeOut = false,
  });
}
