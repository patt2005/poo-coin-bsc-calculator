class CurrencyInfo {
  final String name;
  final String symbol;
  final String description;
  final String logoUrl;
  final List<dynamic> tags;
  double? cointPrice;
  double? dailyVolumeTrade;

  CurrencyInfo({
    this.cointPrice,
    this.dailyVolumeTrade,
    required this.name,
    required this.symbol,
    required this.description,
    required this.logoUrl,
    required this.tags,
  });

  static CurrencyInfo fromJson(Map<String, dynamic> data) {
    return CurrencyInfo(
      name: data["name"],
      symbol: data["symbol"],
      description: data["description"],
      logoUrl: data["logo"],
      tags: data["tags"] ?? [],
    );
  }
}
