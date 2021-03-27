

class TodoModal{
  String userId;
  String id;
  String title;
  String completed;

  TodoModal.fromJson(Map<String, dynamic> json) {
    userId = json['userId'].toString();
    id = json['id'].toString();
    title = json['title'];
    completed = json['completed'].toString();
  }

}