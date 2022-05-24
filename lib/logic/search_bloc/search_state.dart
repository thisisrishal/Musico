part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}


class SearchInitial extends SearchState {
  final List<Audio> fullSongs;

  const SearchInitial({required this.fullSongs});

  @override
  List<Audio> get props => fullSongs;
}
