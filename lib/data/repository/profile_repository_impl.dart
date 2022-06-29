import '/domain/model/profile/profile_entity.dart';
import '/domain/repository/profile_repository.dart';

import '../../di/post_di.dart';
import '../api/api_util.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ApiUtil _apiUtil = serviceDiPost<ApiUtil>();

  @override
  Future<ProfileEntity>? getProfile({required int id}) {
    return _apiUtil.getProfile(id: id);
  }

  @override
  Future<ProfileEntity>? getProfileSelf() {
    return _apiUtil.getProfileSelf();
  }

  @override
  Future<List<ProfileEntity>>? getProfiles(
      {String? city, String? type, int? gender}) {
    return _apiUtil.getProfiles(city: city, type: type, gender: gender);
  }

  @override
  Future<List<ProfileEntity>>? getTalents({String? city}) {
    return _apiUtil.getTalents(city: city);
  }
}
