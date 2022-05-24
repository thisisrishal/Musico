import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'switch_state_state.dart';



class SwitchstateCubit extends Cubit<SwitchStateState> {
  SwitchstateCubit() : super(SwitchstateInitial());
  bool changeSwitch(bool switchy) {
    emit(SwitchChange(switchchange: switchy));
    return switchy;
  }
}
