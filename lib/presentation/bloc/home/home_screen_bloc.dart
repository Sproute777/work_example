import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/api/service/catch_exeptions.dart';
import '/di/post_di.dart';
import '/domain/repository/post_repository.dart';
import '/presentation/bloc/home/home_screen_state.dart';

class HomeScreenBloc extends Cubit<HomeScreenState> {
  String errorMessage = "Ошибка";
  final PostRepository _repository = serviceDiPost<PostRepository>();
  HomeScreenBloc() : super(HomeScreenInitial()) {
    emit(HomeScreenInitial());
    getPosts();
  }

  Future<void> getPosts() async {
    emit(HomeScreenLoading());
    _repository
        .getPosts(city: null)
        ?.then((value) => {emit(HomeScreenSuccess(data: value))})
        .catchError((onError) => {
              if (onError.response.statusCode == 400)
                {
                  errorMessage = onError.response.data['detail'],
                },
              emit(HomeScreenErrorState(
                  CatchException.convertException(onError)))
            })
        .onError((error, stackTrace) => {
              emit(HomeScreenErrorState(CatchException.convertException(error)))
            });
  }
}
