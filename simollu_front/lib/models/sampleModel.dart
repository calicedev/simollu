class SampleModel {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  SampleModel({required this.userId, required this.id, required this.title, required this.completed});

  factory SampleModel.fromJson(Map<String, dynamic> json) {
    return SampleModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}