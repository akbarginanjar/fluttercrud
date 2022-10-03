class User {
  final String id;
  final String name;
  final String alamat;

  User({
    required this.id,
    required this.name,
    required this.alamat,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      alamat: json['alamat'],
    );
  }
}
