// lib/features/task/domain/usecases/edit_task.dart
import 'package:task_manager/features/task/domain/entities/task.dart';
import 'package:task_manager/features/task/domain/repositories/task_repository.dart';

import 'package:fpdart/fpdart.dart';

class EditTask {
  final TaskRepository taskRepository;

  EditTask({required this.taskRepository});

  Future<Either<String, UserTask>> call(String userId, String taskId, UserTask task) {
    return taskRepository.editTask(userId, taskId, task);
  }
}
