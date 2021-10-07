class SocialUserModel {
  String name;
  String email;
  String phone;
  String uId;
  bool isEmailVerified;
  String image;
  String bio;
  String cover;
  SocialUserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.image,
    this.cover,
    this.isEmailVerified,
    this.bio,
  });
  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    bio = json['bio'];
    image = json['image'];
    isEmailVerified = json['isEmailVerified'];
    cover = json['cover'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'cover': cover,
      'isEmailVerified': isEmailVerified,
      'image': image,
      'bio': bio,
    };
  }
}
