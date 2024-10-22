import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_api/bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc_api/constants/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:floating_menu_panel/floating_menu_panel.dart';

import 'package:todo_bloc_api/presentations/widgets/taskwidget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

// late Future<List<Todo>> tasks;
  final TextEditingController titlecontroller = TextEditingController();

  final TextEditingController descriptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              context.read<TodoBloc>().add(TodoGet());
            },
            child: const Icon(Icons.refresh),
          )
        ],
        backgroundColor: Constants().theme,
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadiusDirectional.vertical(bottom: Radius.circular(20))),
        title: Text('To-Do', style: GoogleFonts.abel(color: Colors.white)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {

                  
                  
                  if (state is TodoFail) {
                    return Center(child: Text(state.error));
                  }
                  if (state is! TodoSuccess) {
                    return const Center(
                      child: CircularProgressIndicator());
                  }

                   if(state is TodoEmpty){
                    return Center(child: Text('No Todo', style: TextStyle(color: Colors.black),));
                   }
                  
                  // final todolist = state.todo;
                  return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: state.todo.length,
                      itemBuilder: (context, index) {
                        final todo = state.todo[index];
                        return TaskWidget(todo: todo, index: index);
                      });
                },
              )),
          FloatingMenuPanel(
            onPressed: (index) {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const AddScreen()));
              showdialog(context);
            },
            buttons: const [Icons.add_task_outlined],
            panelIcon: Icons.add,
            positionTop: 50,
            size: 60,
            backgroundColor: Constants().theme,
            //positionLeft: 10,
          )
        ],
      ),
    );
  }

  Future<dynamic> showdialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Task'),
            content: Column(
              children: [
                TextField(
                  controller: titlecontroller,
                  decoration: const InputDecoration(labelText: 'Title'),
                  minLines: 1,
                  maxLines: 3,
                ),
                TextField(
                    controller: descriptioncontroller,
                    decoration: const InputDecoration(labelText: 'description'),
                    minLines: 1,
                    maxLines: 2)
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    print('cancel');
                    Navigator.pop(context);
                    titlecontroller.clear();
                    descriptioncontroller.clear();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (titlecontroller.text.isNotEmpty &&
                        descriptioncontroller.text.isNotEmpty) {
                      // final todo = Todo(title: titlecontroller.text , description: descriptioncontroller.text);
                      context.read<TodoBloc>().add(TodoAdd(
                          titlecontroller.text, descriptioncontroller.text));
                      Navigator.pop(context);
                    } else {
                      return;
                    }

                    titlecontroller.clear();
                    descriptioncontroller.clear();
                    print('add');
                  },
                  child: const Text("Add"))
            ],
          );
        });
  }
}
