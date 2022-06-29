import '/domain/model/favorite/favorite_entity.dart';

abstract class FavoriteRepository {
  Future<List<FavoriteEntity>>? getFavorites();
}
