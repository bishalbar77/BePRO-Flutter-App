class NewsFeed {
  int ID;
  String caption;
  String url;
  String name;
  String email;
  String image;
  String created_at;
  String likes;

  NewsFeed ({
    this.ID,
    this.caption,
    this.url,
    this.name,
    this.email,
    this.image,
    this.created_at,
    this.likes
  });

  factory NewsFeed.fromJson(Map<String, dynamic> item) {
    return NewsFeed(
        ID: item['id'],
        caption: item['caption'],
        name: item['name'],
        email: item['email'],
        image: item['image'],
        created_at: item['created_at'],
        likes: item['likes'],
        url: item['url']
    );
  }
}