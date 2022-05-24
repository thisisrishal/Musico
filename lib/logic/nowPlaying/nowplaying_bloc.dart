import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';


import '../../database/dbSongs.dart';

part 'nowplaying_event.dart';
part 'nowplaying_state.dart';

class NowplayingBloc extends Bloc<NowplayingEvent, NowplayingState> {
  var box = MusicBox.getInstance();

  List<dbSongs> databaseSongs = [];
  List<dynamic>? favSongs = [];

  //default pause
  IconData playbtn = Icons.pause_circle_outline_rounded;

  bool isplaying = false;
  bool isLooping = false;

  NowplayingBloc()
      : super(
          NowplayingInitial(),
        ) {
    on<NowplayingEvent>((event, emit) {});
    on<NowPlayingLoadedEvent>(_onNowPlayLoad);
  }

  void _onNowPlayLoad(
    NowPlayingLoadedEvent event,
    Emitter<NowplayingState> emit,
  ) {
    String id, title, subtitle;

    final databaseSongs = box.get("musics") as List<dbSongs>;
    dbSongs getCurrentPlayingSong(List<dbSongs> songs, String id) =>
        songs.firstWhere((element) => element.id.toString().contains(id));

    final temp = getCurrentPlayingSong(databaseSongs, event.songId);

    favSongs = box.get("favourites");
    Audio find(List<Audio> source, String fromPath) {
      return source.firstWhere((element) {
        return element.path == fromPath;
      });
    }

    // if (event.playing != null) {
      final myaudio =
          find(event.songList, event.playing);
      final currentSong = databaseSongs.firstWhere(
          (element) => element.id.toString() == myaudio.metas.id.toString());
      id = myaudio.metas.id.toString();
      title = myaudio.metas.title.toString();
      subtitle = myaudio.metas.artist.toString();
    emit(NowPlayingLoaded(id: id, title: title, subtitle: subtitle,myaudio: myaudio,nowPlaying: temp));

    }


// event.playlists.add ()
    // emit(FavUpdate(intnewaldkfjsdlfjklsdfjklsdjfkljsdklfj:));
  }
// }
