import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../database/dbSongs.dart';

part 'fav_songs_event.dart';
part 'fav_songs_state.dart';
class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc()
      : super(FavouritesInitial(
            list: MusicBox.getInstance().get("favourites")!)) {
    on<RemoveFav>((event, emit) {
      emit(FavouritesInitial(list: MusicBox.getInstance().get("favourites")!));
      emit(FavChange(list: MusicBox.getInstance().get("favourites")!));
    });
  }
}

// class FavSongsBloc extends Bloc<FavSongsEvent, FavSongsState> {

//   final databaseSongs = MusicBox.getInstance().get("musics") as List<dbSongs>;
  

  // FavSongsBloc() : super(FavSongsInitial()) {
  //   on<FavSongsEvent>((event, emit) {});
  //   on<FavItemEvent>(_onFavItemEvent);
  //   on<AddtoFavEvent>(_onAddtoFavEvent);
  // }
  // void _onFavItemEvent(FavItemEvent event, Emitter<FavSongsState> emit) {
  //      Widget icon;

  //   final box = MusicBox.getInstance();
  //   List<dynamic>? favSongs = [];
  //   final myaudio = find(event.songList, event.playing!.audio.assetAudioPath);

  //   final currentSong = databaseSongs.firstWhere(
  //       (element) => element.id.toString() == myaudio.metas.id.toString());

  //   favSongs = box.get("favourites");

  //   favSongs!
  //           .where(
  //             (element) => element.id.toString() == currentSong.id.toString(),
  //           )
  //           .isEmpty
  //       ? icon = Image.asset(
  //           'assets/images/love.png',
  //           color: Colors.white,
  //           height: 25,
  //         )
  //       : icon = Image.asset(
  //           'assets/images/love.png',
  //           color: Color.fromARGB(255, 194, 36, 25),
  //           height: 25,
  //         );

  //   emit(FavItem(icon: icon));
  // }

  // void _onAddtoFavEvent(
  //     AddtoFavEvent event, Emitter<FavSongsState> state) async {
  //   // print('======================');
  //   // final box = MusicBox.getInstance();
  //   // List favsongs = box.get('favourites')!.toList();

  //   // // print(event.playing!.audio.audio.metas.id);
  //   // favsongs.forEach((element) {
  //   //   if (element.id.toString() == event.playing!.audio.audio.metas.id) {
  //   //     print('inFAv');
  //   //   } else {
  //   //     print('Not in fav');
  //   //   }
  //   // });
  //   // print('=========++++===============');
  // }

  // dbSongs getCurrentPlayingSong(List<dbSongs> songs, String id) {
  //   return songs.firstWhere(
  //     (element) => element.id.toString().contains(id),
  //   );
  // }

  // Audio find(List<Audio> source, String fromPath) {
  //   return source.firstWhere((element) {
  //     return element.path == fromPath;
  //   });
  // }

  // dbSongs databaseSongsFunction(List<dbSongs> songs, String id) {
  //   return songs.firstWhere(
  //     (element) => element.id.toString().contains(id),
  //   );
  // }
// }
