class NewsRequest {
  final String? query;
  final String? fromDate;
  final String? to;
  final String? sortBy;
  final String apiKey;

  NewsRequest({
    this.query,
    this.fromDate,
    this.to,
    this.sortBy,
    required this.apiKey,
  });

  Map<String, dynamic> toJson() {
    return {
      "q": query ?? '',
      "from": fromDate ?? '',
      "to": to ?? '',
      "sortBy": sortBy ?? '',
      "apiKey": apiKey,
    };
  }
}
