class User {
  int ID;
  String name;
  String email;
  String phone;
  String url;
  String type;

  User ({
    this.ID,
    this.name,
    this.email,
    this.phone,
    this.url,
    this.type
  });

  factory User.fromJson(Map<String, dynamic> item) {
    return User(
        ID: item['id'],
        name: item['name'],
        email: item['email'],
        phone: item['phone'],
        url: item['url'],
        type: item['type']
    );
  }
}