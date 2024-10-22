part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

class TodoInitial extends TodoState {}


class TodoSuccess extends TodoState{
  final List<Todo> todo;

  TodoSuccess({required this.todo});
}

class TodoFail extends TodoState{
  final String error;

  TodoFail({required this.error});
}

class TodoEmpty extends TodoState{}