class User {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String? token;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'token': token,
    };
  }
}