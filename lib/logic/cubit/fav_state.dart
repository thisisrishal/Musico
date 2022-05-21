// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'fav_cubit.dart';

abstract class FavState extends Equatable {
  const FavState();

  @override
  List<Object> get props => [];
}

class FavInitial extends FavState {
  Color color;
  FavInitial({
    required this.color,
  });
}
