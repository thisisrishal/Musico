// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'fav_songs_bloc.dart';

abstract class FavSongsEvent {
  const FavSongsEvent();
}

// class FavItemEvent extends FavSongsEvent {
//   // Widget throwIcon;
//   Playing? playing;
//   List<Audio> songList;

//   FavItemEvent(
//       {
//       // required this.throwIcon,
//       required this.playing,
//       required this.songList});
// }

// class AddtoFavEvent extends FavSongsEvent {
//   Playing? playing;
//   List<Audio> songList;

//   AddtoFavEvent({required this.playing, required this.songList});
// }

// class RemoveFavEvent extends FavSongsEvent {
//   Playing? playing;
//   List<Audio> songList;

//   RemoveFavEvent({required this.playing, required this.songList});
// }

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();
}

class RemoveFav extends FavouritesEvent {
  @override
  List<Object?> get props => [];
}
