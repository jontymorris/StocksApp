class Article {
  String title;
  String summary;
  String publishDate;
  String links;
  String icon;

  Article({this.title, this.summary, this.publishDate, this.links, this.icon});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        title: json['title'],
        summary: json['summary'],
        publishDate: json['publishDate'],
        links: json['links'],
        icon: json['icon']);
  }
}
