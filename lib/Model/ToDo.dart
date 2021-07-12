class ToDoModel {
  int userId;
  int id;
  String title;
  bool completed;

  ToDoModel(
      {required this.userId,
        required this.id,
        required this.title,
        required this.completed
      });

  factory ToDoModel.fromJson(Map<String, dynamic> data){
    return ToDoModel(
        userId: data["userId"],
        id : data["id"],
        title: data["title"],
        completed: data["completed"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId" : userId,
      "id" : id,
      "title" : title,
      "completed" : completed
    };
  }

}