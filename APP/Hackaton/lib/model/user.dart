class User {
  final String email;
  final String phoneNumber;
  final String name;
  final int age;
  final bool isAdmin;
  final String profileImg;
  final DateTime created;
  final method = 'user_data';
  User(
      {this.email,
      this.phoneNumber,
      this.name,
      this.isAdmin,
      this.age,
      this.profileImg,
      this.created});
  factory User.fromJson(Map<String, dynamic> json) => _itemFromJson(json);
}

User _itemFromJson(Map<String, dynamic> json) {
  return User(
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String ?? 'Sin teléfono registrado',
      name: json['name'] as String,
      isAdmin: json['isAdmin'] as bool,
      age: json['age'] as int ?? 0,
      profileImg: json['profile_img'] as String,
      created: DateTime.parse(json['createdAt']));
}
