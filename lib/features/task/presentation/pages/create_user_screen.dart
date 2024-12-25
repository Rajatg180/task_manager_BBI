import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task/presentation/bloc/task_bloc.dart';
import 'package:task_manager/features/task/presentation/bloc/task_event.dart';
import 'package:task_manager/features/task/presentation/bloc/task_state.dart';
import 'package:task_manager/features/task/presentation/pages/task_screen.dart';

class CreateUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create User")),
      body: Center(
        child: BlocConsumer<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is TaskUserCreated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TaskScreen(userId: state.userId)),
              );
            } else if (state is TaskError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is TaskLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<TaskBloc>().add(CreateUserEvent());
                  },
                  child: Text("Create New User"),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _showLoginDialog(context);
                  },
                  child: Text("Login"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    final TextEditingController _userIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter User ID"),
          content: TextField(
            controller: _userIdController,
            decoration: InputDecoration(hintText: "User ID"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (_userIdController.text.isNotEmpty) {
                  // Navigate to TaskScreen with the entered userId
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskScreen(userId: _userIdController.text),
                    ),
                  );
                } else {
                  // Show a message if no user ID is entered
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a user ID")),
                  );
                }
              },
              child: Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
