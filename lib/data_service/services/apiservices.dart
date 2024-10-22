import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_bloc_api/model/task_model.dart';

class ApiServices {
  Future<void> addTodo(String title, String description) async {
    const url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);

    try {
      final body = {
        "title": title,
        "description": description,
        "is_completed": false
      };

      final response = await http.post(uri,
          body: jsonEncode(body),
          headers: {"Content-Type": "application/json"});

      if (response.statusCode != 201) {
        throw Exception('failed to add todo');
      }
    } catch (error) {
      print('error $error');
    }
  }

  Future<List<Todo>?> gettodo() async {
    const url = "https://api.nstack.in/v1/todos?page=1&limit=10";
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsondata = jsonDecode(response.body);
        final List<dynamic> jsonList = jsondata["items"];

        final List<Todo> todos =
            jsonList.map((todo) => Todo.fromJson(todo)).toList();
            print(todos);
        return todos;
      } else {
        print('failed to get the todo');
        return null;
      }
    } catch (error) {
      print('error " $error');
      return null;
    }
  }

  Future<void> deletetodo(String userid ) async{
    final url = "https://api.nstack.in/v1/todos/$userid";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    if(response.statusCode == 200){
      print('deleted successfullly');
    }
  }

  Future<void> updateTodo(String? userid , String? title , String? description) async{

    final url = "https://api.nstack.in/v1/todos/$userid";
    final uri = Uri.parse(url);

    try{
       final body = {
        "title": title,
        "description": description,
        "is_completed": false
      };

    final response = await http.put(uri,
    body: jsonEncode(body),
    headers: {"Content-Type": "application/json"}

    );

    if(response.statusCode !=201){
      throw Exception('failed to update todo');
    }
    }catch(error){
      print('error $error');
    }

   
  }
}
