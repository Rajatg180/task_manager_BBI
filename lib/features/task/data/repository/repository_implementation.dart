import 'package:task_manager/features/task/data/datasource/remote/remote_data_source.dart';
import 'package:task_manager/features/task/domain/entities/task.dart';
import 'package:fpdart/fpdart.dart';
import 'package:task_manager/features/task/domain/repositories/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  
  final TaskRemoteDataSource taskRemoteDataSource;

  TaskRepositoryImpl({required this.taskRemoteDataSource});

  @override
  Future<Either<String, List<UserTask>>> fetchTasks(String userId) async {
    return await taskRemoteDataSource.fetchTasks(userId);
  }

  @override
  Future<Either<String, UserTask>> addTask(String userId, UserTask task) async {
    return await taskRemoteDataSource.addTask(userId, task);
  }

  @override
  Future<Either<String, UserTask>> editTask(String userId, String taskId, UserTask task) async {
    return await taskRemoteDataSource.editTask(userId, taskId, task);
  }

  @override
  Future<Either<String, String>> deleteTask(String userId, String taskId) async {
    return await taskRemoteDataSource.deleteTask(userId, taskId);
  }

  @override
  Future<Either<String, String>> createUser() async {
    return await taskRemoteDataSource.createUser();
  }
}
