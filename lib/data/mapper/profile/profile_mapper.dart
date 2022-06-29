import '/data/api/constants.dart';
import '/data/api/models/profile/api_profile_response.dart';
import '/domain/model/profile/profile_entity.dart';

class ProfileMapper {
  static ProfileEntity fromApi(ApiProfileResponse response) {
    return ProfileEntity(
      id: response.id,
      profilePhotos: response.profilePhotos?.map((e) => e.toString()).toList(),
      name: response.name,
      userType: response.userType,
      gender: response.gender,
      age: response.age,
      city: response.city,
      phone: response.phone,
      facebook: response.facebook,
      instagram: response.instagram,
      linkedin: response.linkedin,
      website: response.website,
      about: response.about,
      workerType: response.workerType,
      closeSize: response.closeSize,
      shoesSize: response.shoesSize,
      growth: response.growth,
      bust: response.bust,
      waist: response.waist,
      hips: response.hips,
      lookType: response.lookType,
      skinColor: response.skinColor,
      hairColor: response.hairColor,
      hairLength: response.hairLength,
      isHaveInternationalPassport: response.isHaveInternationalPassport,
      isHaveTattoo: response.isHaveTattoo,
      isHaveEnglish: response.isHaveEnglish,
      photo: response.photo
          ?.replaceAll("http://127.0.0.1", ApiConstants.BASE_URL_IMAGE),
      workType: response.workType,
      userId: response.userId,
    );
  }
}
