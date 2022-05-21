// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'song_bloc.dart';

abstract class SongState {
  const SongState();
}

class Initial extends SongState {

  
}

class FavIconInitial extends SongState {
  IconButton iconButton;
  FavIconInitial({
    required this.iconButton,
  });

  // FavIconInitial({required this.iconButton});
}

class FavIconResult extends SongState {
  Color color;
  Audio currentAudio;
  FavIconResult({
    required this.color,
    required this.currentAudio,
  });
}

class NowPlayingLoaded extends SongState {
  String id;
  String title;
  String Subtitle;

  NowPlayingLoaded({
    required this.id,
    required this.title,
    required this.Subtitle,
  });
}
