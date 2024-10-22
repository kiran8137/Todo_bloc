
class Todo{
  
  String? userid;
  String? title;
  String? description;

  Todo({
    this.userid,
    this.title,
    this.description
  });


  factory Todo.fromJson(Map<String , dynamic> json){
    return Todo(
      userid: json["_id"],
      title: json["title"],
      description: json["description"]

    );
  }

}