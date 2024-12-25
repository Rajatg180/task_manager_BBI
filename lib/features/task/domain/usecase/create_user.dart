// lib/features/task/domain/usecases/create_user.dart

import 'package:task_manager/features/task/domain/repositories/task_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateUser {
  final TaskRepository taskRepository;

  CreateUser({required this.taskRepository});

  // Call the repository to create a new user
  Future<Either<String, String>> call() async {
    return await taskRepository.createUser();
  }
}
