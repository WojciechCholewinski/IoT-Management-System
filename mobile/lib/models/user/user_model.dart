class UserProfile {
  final String email;
  final String firstName;
  final String? lastName;
  final String? photo;

  UserProfile({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.photo,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'] as String?,
      photo: json['photo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'photo': photo,
    };
  }
}
