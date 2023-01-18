class UserModel {
  final String fName;
  final String password;
  final String lName;
  final String email;
  final String profilePic;

  UserModel(
      {required this.email,
      required this.fName,
      required this.lName,
      required this.password,
      required this.profilePic,
      });
}