class Share {
  String name;
  String description;
  String symbol;
  String logo;

  Share({this.name, this.description, this.symbol, this.logo});

  factory Share.fromJson(Map<String, dynamic> json) {
    return Share(
        name: json['name'],
        description: json['description'],
        symbol: json['symbol'],
        logo: json['logo']);
  }
}
