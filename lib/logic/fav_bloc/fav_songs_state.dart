// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'fav_songs_bloc.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();
}

class FavouritesInitial extends FavouritesState {
  final List? favourites = MusicBox.getInstance().get("favourites");
  FavouritesInitial({required List<dynamic> list});

  @override
  List<dynamic> get props => [favourites];
}

class FavChange extends FavouritesState {
  final List? favourites = MusicBox.getInstance().get("favourites");
  FavChange({required List<dynamic> list});

  @override
  List<dynamic> get props => [favourites];
}
