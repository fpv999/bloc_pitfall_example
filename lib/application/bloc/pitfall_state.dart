part of 'pitfall_bloc.dart';

@immutable
sealed class PitfallState extends Equatable {
  final int value;

  const PitfallState(this.value);

  @override
  List<Object?> get props => [value];
}

final class PitfallBlocState extends PitfallState {
  const PitfallBlocState(super.value);
}

final class PitfallBlocInitial extends PitfallState {
  const PitfallBlocInitial() : super(0);
}
