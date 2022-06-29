import 'package:equatable/equatable.dart';

import '/data/api/service/catch_exeptions.dart';
import '/domain/model/favorite/favorite_entity.dart';

abstract class FavoriteModelScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoriteModelScreenInitial extends FavoriteModelScreenState {}

class FavoriteModelScreenLoading extends FavoriteModelScreenState {}

class FavoriteModelScreenErrorState extends FavoriteModelScreenState {
  final CatchException? message;

  FavoriteModelScreenErrorState(this.message);

  @override
  List<Object> get props => [message!];
}

class FavoriteModelScreenLocalErrorState extends FavoriteModelScreenState {
  final String? message;

  FavoriteModelScreenLocalErrorState({this.message});

  @override
  List<Object> get props => [message!];
}

class FavoriteModelScreenSuccess extends FavoriteModelScreenState {
  final List<FavoriteEntity>? data;

  FavoriteModelScreenSuccess({required this.data});
}
