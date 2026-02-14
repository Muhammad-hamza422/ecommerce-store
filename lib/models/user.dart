class UserName {
  final String firstname;
  final String lastname;

  UserName({
    required this.firstname,
    required this.lastname,
  });

  factory UserName.fromJson(Map<String, dynamic> json) {
    return UserName(
      firstname: json['firstname'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
    );
  }

  String get fullName => '$firstname $lastname'.trim();
}

class User {
  final int id;
  final String email;
  final String username;
  final UserName name;
  final String phone;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String? ?? '',
      username: json['username'] as String? ?? '',
      name: UserName.fromJson(json['name'] as Map<String, dynamic>? ?? {}),
      phone: json['phone'] as String? ?? '',
    );
  }
}


