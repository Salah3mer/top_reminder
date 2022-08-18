import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:top_reminder/share/components/components.dart';
import 'package:top_reminder/share/cubit/cubit.dart';
import 'package:top_reminder/share/cubit/states.dart';

class task_screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context,state){
          AppCubit c = AppCubit.get(context);
          return Padding(
            padding: const EdgeInsets.only(top:15,left: 15,right: 15),
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              itemBuilder: (context,index)=>BuildTaskItem(c.newTasks[index], context,index),
              staggeredTileBuilder: (index)=>StaggeredTile.fit(1),
              physics: BouncingScrollPhysics(),
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
              itemCount: c.newTasks.length,

            ),
          );
        },
        listener: (context,state){}
    );
  }
}
