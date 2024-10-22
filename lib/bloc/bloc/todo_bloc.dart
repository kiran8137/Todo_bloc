
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc_api/data_service/services/apiservices.dart';
import 'package:todo_bloc_api/model/task_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ApiServices apiservices;
  TodoBloc(this.apiservices) : super(TodoInitial()) {
      
      on<TodoGet>((event , emit) async{
         
        try{
          final todos = await apiservices.gettodo();
          if(todos!=null){
            emit(TodoSuccess(todo: todos));
          }else{
            emit(TodoFail(error: 'failed to get todo'));
          }
          
        }catch(e){
          print("error");
          emit(TodoFail(error: e.toString()));
        }
      });

      on<TodoAdd>((event , emit) async{

         
        try{
          await apiservices.addTodo(event.title , event.description );
          emit(TodoSuccess(todo: []));
          final todos = await apiservices.gettodo();
          if(todos!=null){
            emit(TodoSuccess(todo: todos));
          }
        }catch(e){
          emit(TodoFail(error: e.toString()));
        }
      });

      on<TodoDelete>((event , emit) async {

        try{
          await apiservices.deletetodo(event.id);
           final todos = await apiservices.gettodo();
          if(todos!=null){
            emit(TodoSuccess(todo: todos));
          } 
          if(todos!.isEmpty){
            emit(TodoEmpty());
          }
        }catch(error){
          emit(TodoFail(error: error.toString()));
        }
        


      });

      on<TodoUpdate>((event , emit) async {
        try{
          await apiservices.updateTodo(event.id, event.title, event.description);
          final todos = await apiservices.gettodo();
          if(todos!=null){
            emit(TodoSuccess(todo: todos));
          }
        }catch(error){
          emit(TodoFail(error: error.toString()));
        }
      });
  }

  

  
}
