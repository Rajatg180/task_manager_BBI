// lib/features/task/domain/usecases/fetch_tasks.dart
import 'package:task_manager/features/task/domain/entities/task.dart';
import 'package:task_manager/features/task/domain/repositories/task_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchTasks {
  final TaskRepository taskRepository;

  FetchTasks({required this.taskRepository});

  Future<Either<String, List<UserTask>>> call(String userId) {
    return taskRepository.fetchTasks(userId);
  }
}
