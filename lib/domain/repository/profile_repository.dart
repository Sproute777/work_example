import '/domain/model/profile/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity>? getProfile({required int id});

  Future<ProfileEntity>? getProfileSelf();

  Future<List<ProfileEntity>>? getTalents({String? city});

  Future<List<ProfileEntity>>? getProfiles(
      {String? city, String? type, int? gender});
}
