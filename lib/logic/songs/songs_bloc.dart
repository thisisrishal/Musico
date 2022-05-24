import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'songs_event.dart';
part 'songs_state.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState> {
  SongsBloc() : super(SongsInitial()) {
    on<SongsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
