// task_state.dart
import 'package:task_manager/features/task/domain/entities/task.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<UserTask> tasks;

  TaskLoaded({required this.tasks});
}

class TaskAdded extends TaskState {
  final UserTask task;

  TaskAdded({required this.task});
}

class TaskEdited extends TaskState {
  final UserTask task;

  TaskEdited({required this.task});
}

class TaskDeleted extends TaskState {}

class TaskError extends TaskState {
  final String message;

  TaskError({required this.message});

}


class TaskUserCreated extends TaskState {
  final String userId;
  TaskUserCreated({required this.userId});
}