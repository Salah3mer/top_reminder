import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_reminder/layout/home_screen.dart';
import 'package:top_reminder/sceens/add/add.dart';
import 'package:top_reminder/sceens/tasks/task_screen.dart';
import 'package:top_reminder/share/bloc_tracker.dart';
import 'package:top_reminder/share/cubit/cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Bloc.observer=MyBlocObserver();
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..CreateDatabase(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.black,
          primarySwatch: Colors.blueGrey
        ),
        debugShowCheckedModeBanner: false,

        home: HomeLayout(),
      ),
    );
  }
}

