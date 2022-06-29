import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/api/service/catch_exeptions.dart';
import '/di/post_di.dart';
import '/domain/repository/profile_repository.dart';
import '/presentation/bloc/profile/profile_model_screen_state.dart';

class ProfileModelScreenBloc extends Cubit<ProfileModelScreenState> {
  ProfileModelScreenBloc() : super(ProfileModelScreenInitial());

  String errorMessage = '';

  final ProfileRepository _repository = serviceDiPost<ProfileRepository>();

  Future<void> getProfile(int profileId) async {
    emit(ProfileLoadingState());
    _repository
        .getProfile(id: profileId)
        ?.then((value) => {emit(ProfileLoadedeState(profileEntity: value))})
        .catchError((onError) => {
              debugPrint('ProfileEror ===== $onError'),
              if (onError.response.statusCode == 400)
                {
                  errorMessage = onError.response.data['detail'],
                },
              emit(ProfileLoadedeErorState(
                  CatchException.convertException(onError)))
            })
        .onError((error, stackTrace) => {
              emit(ProfileLoadedeErorState(
                  CatchException.convertException(error)))
            });
  }

  Future<void> getProfileSelf() async {
    emit(ProfileLoadingState());
    _repository
        .getProfileSelf()
        ?.then((value) => {emit(ProfileLoadedeState(profileEntity: value))})
        .catchError((onError) => {
              debugPrint('ProfileEror ===== $onError'),
              if (onError.response.statusCode == 400)
                {
                  errorMessage = onError.response.data['detail'],
                },
              emit(ProfileLoadedeErorState(
                  CatchException.convertException(onError)))
            })
        .onError((error, stackTrace) => {
              emit(ProfileLoadedeErorState(
                  CatchException.convertException(error)))
            });
  }
}
