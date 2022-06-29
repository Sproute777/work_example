import 'package:equatable/equatable.dart';

import '/data/api/service/catch_exeptions.dart';
import '/domain/model/profile/profile_entity.dart';

enum ListModelScreenStatus { initial, loading, errorState, errorLocal, success }

class ListModelsScreenState extends Equatable {
  final bool hasReachedMax;
  final ListModelScreenStatus status;
  final CatchException? catchException;
  final String? localError;
  final List<ProfileEntity> data;
  const ListModelsScreenState._({
    this.status = ListModelScreenStatus.initial,
    this.hasReachedMax = false,
    this.catchException,
    this.localError,
    this.data = const <ProfileEntity>[],
  });

  const ListModelsScreenState.initial() : this._();

  const ListModelsScreenState.loading()
      : this._(status: ListModelScreenStatus.loading);

  const ListModelsScreenState.errorState(CatchException? catchException)
      : this._(
            status: ListModelScreenStatus.errorState,
            catchException: catchException);

  const ListModelsScreenState.errorLocal(String? localError)
      : this._(
            status: ListModelScreenStatus.errorLocal, localError: localError);

  const ListModelsScreenState.success(
      List<ProfileEntity> data, bool hasReachedMax)
      : this._(
            status: ListModelScreenStatus.success,
            data: data,
            hasReachedMax: hasReachedMax);

  @override
  List<Object?> get props =>
      [status, catchException, localError, data, hasReachedMax];
}
