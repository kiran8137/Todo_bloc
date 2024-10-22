part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}


class TodoAdd extends TodoEvent{
  final String title;
  final String description;

  TodoAdd(this.title, this.description,);
}

class TodoGet extends TodoEvent{}

class TodoUpdate extends TodoEvent{
  final String? id;
  final String? title;
  final String? description;

  TodoUpdate(this.id, this.title, this.description);

}

class TodoDelete extends TodoEvent{
  final String id;

  TodoDelete({required this.id});
  
}
  