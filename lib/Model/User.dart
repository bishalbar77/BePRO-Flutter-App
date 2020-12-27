class User {
  int ID;
  String name;
  String email;
  String url;
  String type;

  User ({
    this.ID,
    this.name,
    this.email,
    this.url,
    this.type
  });

  factory User.fromJson(Map<String, dynamic> item) {
    return User(
        ID: item['id'],
        name: item['name'],
        email: item['email'],
        url: item['url'],
        type: item['type']
    );
  }
}