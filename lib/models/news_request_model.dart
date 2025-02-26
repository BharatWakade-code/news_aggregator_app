class NewsRequest {
  final String? query;
  final String? fromDate;
  final String? to;
  final String? sortBy;
  final String? country;
  final String? category;
  final String apiKey;

  NewsRequest({
    this.query,
    this.fromDate,
    this.to,
    this.sortBy,
    this.country,
    this.category,
    required this.apiKey,
  });

  Map<String, dynamic> toJson() {
    return {
      "q": query ?? '',
      "from": fromDate ?? '',
      "to": to ?? '',
      "sortBy": sortBy ?? '',
      "country": country ?? '',
      "category": category ?? '',
      "apiKey": apiKey,
    };
  }
}
