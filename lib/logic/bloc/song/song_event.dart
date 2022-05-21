// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'song_bloc.dart';

abstract class SongEvent {
  const SongEvent();
}

class PlaylistUpdate extends SongEvent {
  final List playlists;
  PlaylistUpdate({required this.playlists});
}

class getPlaying extends SongEvent {
  // FavIconInitial({required this.iconButton});
}

class FavIconInitialevent extends SongEvent {
  AsyncSnapshot<Playing?> playing;
  List? favsongs;
  FavIconInitialevent({
    required this.playing,
    required this.favsongs,
  });
}

class FavUpdate extends SongEvent {
  final List<Audio> PassedAudioList;
  AsyncSnapshot<Playing?> playing;
  String id;

  FavUpdate({
    required this.PassedAudioList,
    required this.playing,
    required this.id,
  });
}

class NowPlayingLoad extends SongEvent {
  Audio audio;
  NowPlayingLoad({
    required this.audio,
  });
}

class LoopUpdate extends SongEvent {
  final bool loop;
  LoopUpdate({required this.loop});
}
