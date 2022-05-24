part of 'switch_state_cubit.dart';

abstract class SwitchStateState extends Equatable {
  const SwitchStateState();

  @override
  List<Object> get props => [];
}

class SwitchstateInitial extends SwitchStateState {}

class SwitchChange extends SwitchStateState {
  final bool switchchange;

  const SwitchChange({required this.switchchange});
  @override
  List<Object> get props => [switchchange];
}
