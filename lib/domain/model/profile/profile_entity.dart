class ProfileEntity {
  final int? id;
  final List<String>? profilePhotos;
  final String? name;
  final String userType;
  final int? gender;
  final int? age;
  final String? city;
  final String? phone;
  final String? facebook;
  final String? instagram;
  final String? linkedin;
  final String? website;
  final String? about;
  final int? workerType;
  final int? closeSize;
  final int? shoesSize;
  final int? growth;
  final int? bust;
  final int? waist;
  final int? hips;
  final String? lookType;
  final String? skinColor;
  final String? hairColor;
  final String? hairLength;
  final bool isHaveInternationalPassport;
  final bool isHaveTattoo;
  final bool isHaveEnglish;
  final String? photo;
  final String workType;
  final int userId;

  ProfileEntity({
    required this.id,
    required this.profilePhotos,
    required this.name,
    required this.userType,
    required this.gender,
    required this.age,
    required this.city,
    required this.phone,
    required this.facebook,
    required this.instagram,
    required this.linkedin,
    required this.website,
    required this.about,
    required this.workerType,
    required this.closeSize,
    required this.shoesSize,
    required this.growth,
    required this.bust,
    required this.waist,
    required this.hips,
    required this.lookType,
    required this.skinColor,
    required this.hairColor,
    required this.hairLength,
    required this.isHaveInternationalPassport,
    required this.isHaveTattoo,
    required this.isHaveEnglish,
    required this.photo,
    required this.workType,
    required this.userId,
  });
}
