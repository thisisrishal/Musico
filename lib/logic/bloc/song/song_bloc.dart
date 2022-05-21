import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:musico_scratch/database/dbSongs.dart';

import '../../../main_page/widgets/play_song.dart';

part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  SongBloc()
      : super(Initial(
          )) {
    on<FavIconInitialevent>(_favIconInitial);
    on<PlaylistUpdate>(_onPlaylistUpdate);
    on<FavUpdate>(_onFavUpdate);
    on<LoopUpdate>(_onLoopUpdate);
    on<NowPlayingLoad>(_onNowPlayLoad);
  }

  void _onNowPlayLoad(
    NowPlayingLoad event,
    Emitter<SongState> emit,
  ) {
    String id, title, subtitle;
    id = event.audio.metas.id.toString();
    title = event.audio.metas.title.toString();
    subtitle = event.audio.metas.artist.toString();

    emit(NowPlayingLoaded(id: id, title: title, Subtitle: subtitle));

// event.playlists.add ()
    // emit(FavUpdate(intnewaldkfjsdlfjklsdfjklsdjfkljsdklfj:));
  }

  void _onPlaylistUpdate(
    PlaylistUpdate event,
    Emitter<SongState> emit,
  ) {
// event.playlists.add ()
    // emit(FavUpdate(intnewaldkfjsdlfjklsdfjklsdjfkljsdklfj:));
  }

  void _onFavUpdate(
    FavUpdate event,
    Emitter<SongState> emit,
  ) {
    print('=========settanu==============');

    final box = MusicBox.getInstance();
    final databaseSongs = box.get("musics") as List<dbSongs>;
    dbSongs getCurrentPlayingSong(List<dbSongs> songs, String id) {
      return songs.firstWhere(
        (element) => element.id.toString().contains(id),
      );
    }

    final temp = getCurrentPlayingSong(databaseSongs, event.id);
    List<dynamic>? favSongs = box.get("favourites");
    final myaudio =
        find(event.PassedAudioList, event.playing.data!.audio.assetAudioPath);
    final currentSong = databaseSongs.firstWhere(
        (element) => element.id.toString() == myaudio.metas.id.toString());

    if (favSongs!
        .where(
          (element) => element.id.toString() == currentSong.id.toString(),
        )
        .isEmpty) {
      addToFav(favSongs, currentSong, box);
      emit(FavIconResult(color: Colors.red, currentAudio: myaudio));
    } else {
      removeFromFav(favSongs, currentSong, box, temp);
      emit(FavIconResult(color: Colors.yellow, currentAudio: myaudio));
    }
  }

  // emit(TodosLoaded(todos: event.todos));

  _favIconInitial(FavIconInitialevent event, Emitter<SongState> emit) {
    print('=============ivide ethi=========');
    


    

    
    emit(FavIconInitial(
      iconButton: 
        // iconButton: IconButton(onPressed: () {}, icon: Icon(Icons.alarm))
        ));
  }
}

void _onLoopUpdate(
  LoopUpdate event,
  Emitter<SongState> emit,
) {
  // emit(TodosLoaded(todos: event.todos));
}
addToFav(favSongs, currentSong, box) {
  favSongs!.add(currentSong);
  box.put("favourites", favSongs!);
  favSongs = box.get('favourites');
}

removeFromFav(favSongs, currentSong, box, temp) {
  favSongs!
      .removeWhere((element) => element.id.toString() == temp.id.toString());
  box.put("favourites", favSongs);
  favSongs = box.get('favourites');
}
