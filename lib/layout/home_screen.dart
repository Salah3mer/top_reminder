import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:top_reminder/sceens/tasks/task_screen.dart';
import 'package:top_reminder/share/cubit/cubit.dart';
import 'package:top_reminder/share/cubit/states.dart';
class HomeLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(

      listener: (context,state){},
      builder:(context,state){
        AppCubit c= AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor:Colors.white,
            elevation: 0,
            title: Container(
              padding: EdgeInsetsDirectional.only(start: 15),
              child: Text(c.titles[c.CurrantIndex],
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
            ),

          ),

          body: c.screen[c.CurrantIndex],

          bottomNavigationBar:CurvedNavigationBar(
            color: Colors.white,
            backgroundColor: Colors.black,
            buttonBackgroundColor: Colors.white,
            animationCurve: Curves.easeInOutSine,
            animationDuration: Duration(milliseconds: 200),
            items: [
              Icon(Icons.menu_open_rounded,size: 30,),
              Icon(Icons.add,size: 30,) ,
              Icon(Icons.check_circle_outline_rounded,size: 30,),
            ],
            index:c.CurrantIndex ,
            onTap: (index){
                c.ButtonNavBar(index);
              print(index);
            },

          ),

        );
      } ,

    );
  }
}


