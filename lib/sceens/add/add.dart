import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:top_reminder/share/components/components.dart';
import 'package:top_reminder/share/cubit/cubit.dart';
import 'package:top_reminder/share/cubit/states.dart';

class add_Screen extends StatelessWidget {
  var title = TextEditingController();
  var Task = TextEditingController();
  var date = TextEditingController();
  var time = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit c = AppCubit.get(context);
        return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.only(start: 10),
                    child: TextFormField(
                      controller: title,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle: TextStyle(fontSize: 27),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.only(start: 10),
                    child: TextFormField(
                      controller: Task,
                      maxLines: 8,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        hintText:  'Write Your Task',
                        hintStyle: TextStyle(fontSize: 20),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  MyFormField(
                    controller: date,
                    suffix: Icons.date_range_rounded,
                    label: 'Date',
                    readonly: true,
                    ontap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.parse('2022-08-27'),
                      ).then((value) {
                        date.text = DateFormat.yMMMd().format(value);
                      });
                    },
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'date must not be empty';
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyFormField(
                    controller: time,
                    readonly: true,
                    suffix: Icons.timer_rounded,
                    label: 'Time',
                    ontap: () {
                      showTimePicker(
                              context: context, initialTime: TimeOfDay.now())
                          .then((value) {
                        time.text = value.format(context).toString();
                      });
                    },
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'time must not be empty';
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 120,
                    child: ListView.separated(
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          c.changeColorIndex(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: c.colors[index],
                            borderRadius: BorderRadius.circular(14),
                          ),
                          height: 60,
                          width: 60,
                          child: c.colorIndex == index
                              ? Icon(
                                  Icons.check,
                                )
                              : null,
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      itemCount: c.colors.length,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: MaterialButton(
                        onPressed: () {
                          c.InsertToDatabase(title: title.text, task: Task.text, date: date.text, time: time.text);
                          c.CurrantIndex=0;
                          title.text='';  Task.text='';  date.text='';  time.text='';
                        },
                        color: Colors.black,

                        child: Icon(Icons.add,color: Colors.white,),
                        shape: CircleBorder(),

                       height: 70,
                        minWidth: 65,


                      ),
                    ),
                  ),
                ],
              ),
            ),
          );

      },
    );
  }
}
