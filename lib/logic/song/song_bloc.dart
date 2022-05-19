import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  SongBloc() : super(SongInitial()) {
    on<SongEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
