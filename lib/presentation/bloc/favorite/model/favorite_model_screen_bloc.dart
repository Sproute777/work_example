import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/api/service/catch_exeptions.dart';
import '/di/post_di.dart';
import '/domain/repository/favorite_repository.dart';
import '/presentation/bloc/favorite/model/favorite_model_screen_state.dart';

class FavoriteModelScreenBloc extends Cubit<FavoriteModelScreenState> {
  String errorMessage = "dsfgdsgf";
  final FavoriteRepository _repository = serviceDiPost<FavoriteRepository>();

  FavoriteModelScreenBloc() : super(FavoriteModelScreenInitial());

  Future<void> getFavorites() async {
    emit(FavoriteModelScreenLoading());
    _repository
        .getFavorites()
        ?.then((value) => {emit(FavoriteModelScreenSuccess(data: value))})
        .catchError((onError) => {
              if (onError.response.statusCode == 400)
                {
                  errorMessage = onError.response.data['detail'],
                },
              emit(FavoriteModelScreenErrorState(
                  CatchException.convertException(onError)))
            })
        .onError((error, stackTrace) => {
              emit(FavoriteModelScreenErrorState(
                  CatchException.convertException(error)))
            });
  }
}
