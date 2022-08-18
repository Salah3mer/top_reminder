import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:top_reminder/share/cubit/cubit.dart';
import 'package:top_reminder/share/cubit/states.dart';

Widget MyFormField({
  @required TextEditingController controller,
  @required String label,
  Function validate,
  Function ontap,
  Function onChange,
  Function onSubmit,
  TextInputType type,
  IconData prefix,
  IconData suffix,
  bool readonly = false,
  bool isPassword = false,
}) =>
    TextFormField(
      readOnly: readonly,
      controller: controller,
      validator: validate,
      onTap: ontap,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      decoration: InputDecoration(

        fillColor: Colors.grey[300],
        filled: true,
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? Icon(
                suffix,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

Widget BuildTaskItem(Map model, context, index) =>
    BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit c = AppCubit.get(context);
        return index % 2 == 0
            ? Slidable(
          key: Key(model['id'].toString()),

          /// نوع الانميتد
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconSlideAction(
                  caption: 'Done',
                  foregroundColor: Colors.deepOrange,
                  icon: Icons.check_box_outlined,
                  onTap: () {
                    c.UpdateDatabase('Done', model['id']);
                  },
                ),
                IconSlideAction(
                  caption: 'Delete',
                  foregroundColor: Colors.deepOrange,
                  icon: Icons.delete_forever,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          title: Text('Delete'),
                          content:
                          Text('Do You Wont Delete This Task ?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                c.deletefromDatabase(model['id']);
                                Navigator.pop(context);
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        ));
                  },
                ),
              ],
            ),
          ],

          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: c.colors[model['color']],
            ),
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize:
                        MediaQuery.of(context).size.height * 0.018,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 5.0, bottom: 11.0),
                    child: Text(
                      '${model['task']}',
                      style: TextStyle(
                        fontSize:
                        MediaQuery.of(context).size.height * 0.018,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.03,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 3),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${model['date']}' + ',',
                              style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.height *
                                    0.014,
                              ),
                            ),
                            Text(
                              '${model['time']}',
                              style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.height *
                                    0.014,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
            : Slidable(
          key: Key(model['id'].toString()),

          /// نوع الانميتد
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,

          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconSlideAction(
                  caption: 'Done',
                  foregroundColor: Colors.deepOrange,
                  icon: Icons.check_box_outlined,
                  onTap: () {
                    c.UpdateDatabase('Done', model['id']);
                  },
                ),
                IconSlideAction(
                  caption: 'Delete',
                  foregroundColor: Colors.deepOrange,
                  icon: Icons.delete_forever,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          title: Text('Delete'),
                          content:
                          Text('Do You Wont Delete This Task ?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                c.deletefromDatabase(model['id']);
                                Navigator.pop(context);
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        ));
                  },
                ),
              ],
            ),
          ],
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: c.colors[model['color']],
            ),
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize:
                        MediaQuery.of(context).size.height * 0.018,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 5.0, bottom: 11.0),
                    child: Text(
                      '${model['task']}',
                      style: TextStyle(
                        fontSize:
                        MediaQuery.of(context).size.height * 0.018,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.03,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 3),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${model['date']}' + ',',
                              style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.height *
                                    0.014,
                              ),
                            ),
                            Text(
                              '${model['time']}',
                              style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.height *
                                    0.014,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
