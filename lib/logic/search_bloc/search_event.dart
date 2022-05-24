part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}
class SearchInputEvent extends SearchEvent {
  final String search;

  const SearchInputEvent({required this.search});
  @override
  List<Object> get props => [search];
}
