import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_api/bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc_api/data_service/services/apiservices.dart';
import 'package:todo_bloc_api/presentations/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ApiServices apiServices = ApiServices();
    return BlocProvider(
      create: (context) => TodoBloc(apiServices)..add(TodoGet()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home:  HomeScreen(),
      ),
    );
  }
}

 