import '/data/api/api_util.dart';
import '/di/post_di.dart';
import '/domain/model/favorite/favorite_entity.dart';
import '/domain/repository/favorite_repository.dart';

class FavoriteRepositoryImpl extends FavoriteRepository {
  final ApiUtil _apiUtil = serviceDiPost<ApiUtil>();

  @override
  Future<List<FavoriteEntity>>? getFavorites() {
    return _apiUtil.getFavorites();
  }
}
