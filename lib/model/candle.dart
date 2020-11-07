class Candle {
  double open;
  double high;
  double low;
  double close;
  int volume;
  DateTime dateTime;

  Candle({
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
    this.dateTime,
  });

  factory Candle.fromJson(Map<String, dynamic> json) {
    return Candle(
      open: json['Open'] as double,
      high: json['High'] as double,
      low: json['Low'] as double,
      close: json['AdjustedClose'] as double,
      volume: json['Volume'] as int,
      dateTime: DateTime.parse(json['DateTime']),
    );
  }
}
