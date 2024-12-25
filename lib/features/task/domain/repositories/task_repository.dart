// lib/features/task/domain/repositories/task_repository.dart

import 'package:task_manager/features/task/domain/entities/task.dart';
import 'package:fpdart/fpdart.dart';

abstract class TaskRepository {
  Future<Either<String, List<UserTask>>> fetchTasks(String userId);
  Future<Either<String, UserTask>> addTask(String userId, UserTask task);
  Future<Either<String, UserTask>> editTask(String userId, String taskId, UserTask task);
  Future<Either<String, String>> deleteTask(String userId, String taskId);
  Future<Either<String, String>> createUser(); // Method to create a new user
}
