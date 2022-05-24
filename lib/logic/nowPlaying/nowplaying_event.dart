// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'nowplaying_bloc.dart';

@immutable
abstract class NowplayingEvent extends Equatable {
   List<Object?> get props => [];
}

class NowPlayingLoadedEvent extends NowplayingEvent {
  final String songId;
  List<Audio> songList;
 String playing;
  NowPlayingLoadedEvent({
    required this.songId,
    required this.songList,
    required this.playing,
  });

  @override
  List<Object?> get props => [songId,songList,playing];

}
