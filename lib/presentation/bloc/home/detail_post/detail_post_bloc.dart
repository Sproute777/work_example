import 'package:flutter_bloc/flutter_bloc.dart';

import '/di/post_di.dart';
import '/domain/model/auth/post_entity.dart';
import '/domain/repository/post_repository.dart';
import '/presentation/bloc/home/detail_post/detail_post_state.dart';

class DetailPostBloc extends Cubit<DetailPostState> {
  String errorMessage = "dsfgdsgf";
  final PostRepository _repository = serviceDiPost<PostRepository>();

  DetailPostBloc() : super(DetailPostScreenInitial());

  void dispose() {}

  void getPostById(int id) async {
    emit(DetailPostScreenLoading());
    try {
      PostEntity? data = await _repository.getPostById(id: id);
      emit(DetailPostScreenSuccess(data: data));
    } on Exception {
      emit(DetailPostScreenError());
    }
  }
}
