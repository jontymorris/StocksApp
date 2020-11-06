class Candle {
  double open;
  double high;
  double low;
  double close;
  DateTime dateTime;
  int volume;

  Candle({
    this.open,
    this.high,
    this.low,
    this.close,
    this.dateTime,
    this.volume,
  });

  factory Candle.fromJson(Map<String, dynamic> json) {
    return Candle(
      open: json['Open'] as double,
      high: json['High'] as double,
      low: json['Low'] as double,
      close: json['AdjustedClose'] as double,
      dateTime: DateTime.parse(json['DateTime']),
      volume: json['Volume'] as int,
    );
  }
}
