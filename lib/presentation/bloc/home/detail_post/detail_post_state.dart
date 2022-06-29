import 'package:equatable/equatable.dart';

import '/domain/model/auth/post_entity.dart';

abstract class DetailPostState extends Equatable {
  @override
  List<Object> get props => [];
}

class DetailPostScreenInitial extends DetailPostState {}

class DetailPostScreenLoading extends DetailPostState {}

class DetailPostScreenError extends DetailPostState {}

class DetailPostScreenSuccess extends DetailPostState {
  final PostEntity? data;

  DetailPostScreenSuccess({required this.data});
}
