import 'package:equatable/equatable.dart';

import '/data/api/service/catch_exeptions.dart';
import '/domain/model/profile/profile_entity.dart';

abstract class ProfileModelScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileModelScreenInitial extends ProfileModelScreenState {}

class ProfileLoadingState extends ProfileModelScreenState {}

class ProfileLoadedeState extends ProfileModelScreenState {
  final ProfileEntity profileEntity;
  ProfileLoadedeState({required this.profileEntity});
}

class ProfileLoadedeErorState extends ProfileModelScreenState {
  final CatchException? message;

  ProfileLoadedeErorState(this.message);

  @override
  List<Object> get props => [message!];
}
