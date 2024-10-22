// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'package:todo_bloc_api/model/task_model.dart';

// final url = "https://api.nstack.in/v1/todos";

// Future<void> addtask(TextEditingController titlecontroller,
//     TextEditingController descriptioncontroller) async {
//   final title = titlecontroller.text;
//   final description = descriptioncontroller.text;

//   final body = {
//     "title": title,
//     "description": description,
//     "is_completed": false
//   };

//   final Url = url;
//   final uri = Uri.parse(Url);

//   final response = await http.post(uri,
//       body: jsonEncode(body),
//        headers: {"Content-Type": "application/json"}
//        );


//   if (response.statusCode == 201) {
//     print('created successfull');
//     print(response.body);
//   } else {
//     print('created failed');
//   }
// }


// Future<List<Task>> gettask() async{

// final geturl = "${url}?page=1&limit=10";

// final uri = Uri.parse(geturl);

// final response = await http.get(uri);
// if(response.statusCode == 200){
//   print('successfully get the task');
//   print(response.body);
//   final decodeddata = jsonDecode(response.body)["items"] as List;
//   return decodeddata.map((task) => Task.fromJson(task)).toList();
  
// }else{
//   throw Exception('something happened');
// }
// }


// Future<void> deletetask(String? userid)async{
  
//   final deleteurl = "https://api.nstack.in/v1/todos/$userid";
//   final uri = Uri.parse(deleteurl);

//   final response = await http.delete(uri);

//   if(response.statusCode == 200){
//     print('deleted succuesfuly');
    
//   }else{
//     print('deletion failed');
//   }

// }

// Future<void> updatetask(TextEditingController titlecontroller,
//     TextEditingController descriptioncontroller , String userid) async{

//   final title = titlecontroller.text;
//   final description = descriptioncontroller.text;

//   final body = {
//     "title": title,
//     "description": description,
//     "is_completed": false 
//   };

//   final puturl = "https://api.nstack.in/v1/todos/$userid";
//   final uri = Uri.parse(puturl);

//    final response = await http.put(
//     uri ,
//     headers: {
//       "Content-Type": "application/json"
//       },
//     body: jsonEncode(body),

//    );

//    if(response.statusCode == 200){
//     print('updated successfuly');
//    }else{
//     print('failed to update');
//    }
//   }