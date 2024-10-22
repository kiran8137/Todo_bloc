import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_api/bloc/bloc/todo_bloc.dart';

import 'package:todo_bloc_api/model/task_model.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.index, required this.todo});

  final int index;
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size.width;
    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 202, 208, 209),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${todo.title}',
                    style: const TextStyle(fontSize: 25),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true),
                Text(
                  '${todo.description}',
                  style: const TextStyle(fontSize: 15),
                  maxLines: 2,
                   

                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showeditdialog(context, todo, index);
                    print('edit task');
                  },
                  child: const SizedBox(
                    child: Icon(
                      Icons.edit,
                      size: 30,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title:
                                Text('Are you Sure want to delete this todo'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    print('cancel');
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () {
                                    context
                                        .read<TodoBloc>()
                                        .add(TodoDelete(id: todo.userid!));
                                    print('task delete');
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Delete"))
                            ],
                          );
                        });
                  },
                  child: const SizedBox(
                    child: Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> showeditdialog(BuildContext context, Todo todo, int index) {
  TextEditingController edittitlecontroller =
      TextEditingController(text: todo.title);
  TextEditingController editdescriptioncontroller =
      TextEditingController(text: todo.description);
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Todo'),
          content: Column(
            children: [
              TextField(
                controller: edittitlecontroller,
                decoration: const InputDecoration(labelText: 'Title'),
                minLines: 1,
                maxLines: 3,
              ),
              TextField(
                  controller: editdescriptioncontroller,
                  decoration: const InputDecoration(labelText: 'Description'),
                  minLines: 2,
                  maxLines: 6)
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  print('cancel');
                  Navigator.pop(context);
                  edittitlecontroller.clear();
                  editdescriptioncontroller.clear();
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  if (edittitlecontroller.text.isNotEmpty &&
                      editdescriptioncontroller.text.isNotEmpty) {
                    //addtask(edittitlecontroller , editdescriptioncontroller);
                    context.read<TodoBloc>().add(TodoUpdate(
                        todo.userid,
                        edittitlecontroller.text,
                        editdescriptioncontroller.text));
                    Navigator.pop(context);
                  } else {
                    return;
                  }

                  edittitlecontroller.clear();
                  editdescriptioncontroller.clear();
                  print('add');
                },
                child: const Text("Update"))
          ],
        );
      });
}
