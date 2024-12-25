// lib/features/task/domain/usecases/add_task.dart
import 'package:fpdart/fpdart.dart';
import 'package:task_manager/features/task/domain/entities/task.dart';
import 'package:task_manager/features/task/domain/repositories/task_repository.dart';

class AddTask {
  final TaskRepository taskRepository;

  AddTask({required this.taskRepository});

  Future<Either<String, UserTask>> call(String userId, UserTask task) {
    return taskRepository.addTask(userId, task);
  }

}
