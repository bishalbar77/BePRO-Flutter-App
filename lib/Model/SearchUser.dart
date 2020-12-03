class SearchUser {
  int ID;
  String name;
  String email;

  SearchUser ({
    this.ID,
    this.name,
    this.email
  });

  factory SearchUser.fromJson(Map<String, dynamic> item) {
    return SearchUser(
        ID: item['id'],
        name: item['name'],
        email: item['email']
    );
  }
}