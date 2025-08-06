class UserModel {
  int? userId;
  int? userNip;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userPhoto;
  String? userGender;
  int? userRole;
  DateTime? userTglLahir;
  String? userAddress;

  UserModel({
    this.userId,
    this.userNip,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userPhoto,
    this.userGender,
    this.userRole,
    this.userTglLahir,
    this.userAddress,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json["user_id"],
    userNip: json["user_nip"],
    userName: json["user_name"],
    userEmail: json["user_email"],
    userPhone: json["user_phone"],
    userPhoto: json["user_photo"],
    userGender: json["user_gender"],
    userRole: json["user_role"],
    userTglLahir: json["user_tgl_lahir"] == null
        ? null
        : DateTime.parse(json["user_tgl_lahir"]),
    userAddress: json["user_address"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_nip": userNip,
    "user_name": userName,
    "user_email": userEmail,
    "user_phone": userPhone,
    "user_photo": userPhoto,
    "user_gender": userGender,
    "user_role": userRole,
    "user_tgl_lahir":
        "${userTglLahir!.year.toString().padLeft(4, '0')}-${userTglLahir!.month.toString().padLeft(2, '0')}-${userTglLahir!.day.toString().padLeft(2, '0')}",
    "user_address": userAddress,
  };
}
