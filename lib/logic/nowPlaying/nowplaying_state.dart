// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'nowplaying_bloc.dart';

@immutable
abstract class NowplayingState {}

class NowplayingInitial extends NowplayingState {
  // String id,title,subtitle;
  // NowplayingInitial({
  //   required this.id,
  //   required this.title,
  //   required this.subtitle,
  // });
}

class NowPlayingLoaded extends NowplayingState {
  String id, title, subtitle;
  Audio myaudio;
  dbSongs nowPlaying;
  NowPlayingLoaded({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.myaudio,
    required this.nowPlaying,
  });
}
