class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String? address;
  final String? cin;
  final String? token;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.address,
    this.cin,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'],
      address: json['address'],
      cin: json['cin'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'cin': cin,
      'token': token,
    };
  }
}
