import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task/domain/entities/task.dart';
import 'package:task_manager/features/task/presentation/bloc/task_bloc.dart';
import 'package:task_manager/features/task/presentation/bloc/task_event.dart';
import 'package:task_manager/features/task/presentation/bloc/task_state.dart';
import 'package:task_manager/features/task/presentation/pages/add_task_screen.dart';
import 'package:task_manager/service_locator.dart';

class TaskScreen extends StatefulWidget {
  final String userId;

  TaskScreen({required this.userId});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  @override
  void initState() {
    super.initState();
    // Fetch tasks when the screen is loaded
    print("called init");
    context.read<TaskBloc>().add(FetchTasksEvent(userId: widget.userId));
  }


  void _showTaskDetailsDialog(UserTask task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(task.title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Description: ${task.description}'),
                Text('Due Date: ${task.dueDate}'),
                Text('Priority: ${task.priority}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.userId}"),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      context.read<TaskBloc>().add(DeleteTaskEvent(userId: widget.userId, taskId: task.id));
                      setState(() {});
                    },
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => AddTaskScreen(
                    //       userId: widget.userId,
                    //       task: task,
                    //     ),
                    //   ),
                    // );
                     _showTaskDetailsDialog(task);
                  },
                );
              },
            );
          } else if (state is TaskError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text("No tasks available"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTaskScreen(userId: widget.userId),
            ),
          ).then((_){
            context.read<TaskBloc>().add(FetchTasksEvent(userId: widget.userId));
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
