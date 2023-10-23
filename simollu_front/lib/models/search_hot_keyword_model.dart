class SearchHotKeywordModel {
  final int order;
  final String keyword;

  SearchHotKeywordModel({
    required this.order,
    required this.keyword,
  });

  factory SearchHotKeywordModel.fromJson(Map<String, dynamic> json) {
    return SearchHotKeywordModel(
      order: json['order'] as int,
      keyword: json['keyword'] as String,
    );
  }
}