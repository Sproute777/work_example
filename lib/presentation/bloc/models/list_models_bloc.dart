import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/api/service/catch_exeptions.dart';
import '/di/post_di.dart';
import '/domain/repository/profile_repository.dart';
import '/presentation/bloc/models/list_models_screen_state.dart';

import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

//тротлмнг пагинации
const throttleDuration = Duration(milliseconds: 200);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ListModelsBloc extends Bloc<ListModelsEvent, ListModelsScreenState> {
  final ProfileRepository _repository = serviceDiPost<ProfileRepository>();

  var errorMessage = "";

  ListModelsBloc() : super(const ListModelsScreenState.initial()) {
    on<ListModelsFetched>(_onFetched,
        transformer: throttleDroppable(throttleDuration));
  }

  // void dispose() {}

  Future<void> _onFetched(
    ListModelsFetched event,
    Emitter<ListModelsScreenState> emit,
  ) async {
    // if (state.hasReachedMax) return;
    try {
      final data = await _repository.getProfiles(
          city: event.city, type: event.type, gender: event.gender);

      emit(ListModelsScreenState.success(data ?? [], true));
    } catch (onError) {
      emit(ListModelsScreenState.errorState(
          CatchException.convertException(onError)));
    }

    // return emit(ListModelsScreenState2.success(data ?? [], false));
  }
  //  final data = await _repository.getProfiles(
  //       city: event.city, type: event.type, gender: event.gender, startIndex: state.data.length, limit: 20);
  //       data.isEmpty
  //     ? emit( ListModelsScreenState2.success(  List.of(state.data) , true))
  //     : emit(
  //         ListModelsScreenState2.success(
  //         List.of(state.photos)..addAll(photos),
  //         false,
  //         ),
  //       );

}

abstract class ListModelsEvent extends Equatable {
  const ListModelsEvent();

  @override
  List<Object> get props => [];
}

class ListModelsFetched extends ListModelsEvent {
  const ListModelsFetched({this.city, this.type, this.gender});
  final String? city;
  final String? type;
  final int? gender;
}
