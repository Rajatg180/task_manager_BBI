// task_event.dart
import 'package:task_manager/features/task/domain/entities/task.dart';

abstract class TaskEvent {}

class FetchTasksEvent extends TaskEvent {
  final String userId;

  FetchTasksEvent({required this.userId});
}

class AddTaskEvent extends TaskEvent {
  final String userId;
  final UserTask task;

  AddTaskEvent({required this.userId, required this.task});
}

class EditTaskEvent extends TaskEvent {
  final String userId;
  final String taskId;
  final UserTask task;

  EditTaskEvent({required this.userId, required this.taskId, required this.task});
}

class DeleteTaskEvent extends TaskEvent {
  final String userId;
  final String taskId;

  DeleteTaskEvent({required this.userId, required this.taskId});
}


class CreateUserEvent extends TaskEvent {}