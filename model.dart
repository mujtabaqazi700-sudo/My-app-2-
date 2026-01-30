class My_model {
  int? id;
  String title;
  String content;

  My_model({this.id, required this.title, required this.content});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }

  factory My_model.frommap(Map<String, dynamic> map) {
    return My_model(
      title: map['title'],
      content: map['content'],
    );
  }
}
