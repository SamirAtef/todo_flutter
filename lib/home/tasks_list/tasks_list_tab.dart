import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/database/my_database.dart';
import 'package:todo/database/task.dart';
import 'package:todo/home/tasks_list/task_widget.dart';
import 'package:todo/providers/tasks_provider.dart';

class TasksListTab extends StatefulWidget {
  @override
  State<TasksListTab> createState() => _TasksListTabState();
}

class _TasksListTabState extends State<TasksListTab> {
  DateTime selectedDate = DateTime.now();
  late TasksProvider provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.refreshTasks(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    TasksProvider provider = Provider.of<TasksProvider>(context);
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            showYears: true,
            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              if (date == null) return;

              setState(() {
                selectedDate = date;
                // if i delete the next line it will show the same task in all days
                provider.refreshTasks(selectedDate);
              });
            },
            leftMargin: 20,
            monthColor: Colors.black,
            dayColor: Colors.black,
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: Colors.white,
            dotsColor: Theme.of(context).primaryColor,
            selectableDayPredicate: (data) => true,
            locale: 'en_ISO',
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Task>>(
              // future: MyDatabase.getAllTasks(),
              stream: MyDatabase.listenForTasksRealTimeUpdates(selectedDate),
              builder: (buildContext, snapshot) {
                if (snapshot.hasError) {
                  // add try again button
                  return Column(
                    children: [
                      Text('Error loading data ,'
                          'please try again later'),
                    ],
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var data = snapshot.data?.docs.map((e) => e.data()).toList();
                return ListView.builder(
                  itemBuilder: (buildContext, index) {
                    return TaskWidget(data![index]);
                  },
                  itemCount: data!.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
