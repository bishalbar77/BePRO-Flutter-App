class NewsFeed {
  int ID;
  String caption;
  String url;

  NewsFeed ({
    this.ID,
    this.caption,
    this.url
  });

  factory NewsFeed.fromJson(Map<String, dynamic> item) {
    return NewsFeed(
        ID: item['id'],
        caption: item['caption'],
        url: item['url']
    );
  }
}