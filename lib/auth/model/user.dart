class User {
  String userUID;
  String email;
  String firstName;
  String lastName;
  String region;
  DateTime birthdate;
  String phoneNumber;
  String dni;
  String userType;
  String? photo;
  String? userDescription;

  User({
    required this.userUID,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.region,
    required this.birthdate,
    required this.phoneNumber,
    required this.dni,
    required this.userType,
    this.photo,
    this.userDescription,
  });
}
