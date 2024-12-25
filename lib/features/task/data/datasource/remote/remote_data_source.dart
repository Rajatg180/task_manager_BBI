import 'package:fpdart/fpdart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:task_manager/features/task/domain/entities/task.dart';

abstract class TaskRemoteDataSource {
  Future<Either<String, List<UserTask>>> fetchTasks(String userId);
  Future<Either<String, UserTask>> addTask(String userId, UserTask task);
  Future<Either<String, UserTask>> editTask(String userId, String taskId, UserTask task);
  Future<Either<String, String>> deleteTask(String userId, String taskId);
  Future<Either<String, String>> createUser();
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final DatabaseReference _taskRef = FirebaseDatabase.instance.ref('tasks');
  final DatabaseReference _userCounterRef = FirebaseDatabase.instance.ref('user_count');

  @override
  Future<Either<String, List<UserTask>>> fetchTasks(String userId) async {
    try {
      final snapshot = await _taskRef.child(userId).get();

      if (snapshot.exists) {
        final tasksMap = Map<String, dynamic>.from(snapshot.value as Map);
        List<UserTask> tasks = [];
        
        tasksMap.forEach((taskId, taskData) {
          tasks.add(UserTask.fromMap(taskData, taskId));
        });

        tasks.sort((a, b) => b.dueDate.compareTo(a.dueDate)); // Sort tasks by dueDate
        return Right(tasks);
      } else {
        return Left('No tasks found.');
      }
    } catch (error) {
      return Left('Failed to load tasks: $error');
    }
  }

  @override
  Future<Either<String, UserTask>> addTask(String userId, UserTask task) async {
    try {
      final taskRef = _taskRef.child(userId).push();
      await taskRef.set(task.toMap());
      return Right(task.copyWith(id: taskRef.key!));
    } catch (error) {
      return Left('Failed to add task: $error');
    }
  }

  @override
  Future<Either<String, UserTask>> editTask(String userId, String taskId, UserTask task) async {
    try {
      await _taskRef.child(userId).child(taskId).update(task.toMap());
      return Right(task);
    } catch (error) {
      return Left('Failed to edit task: $error');
    }
  }

  @override
  Future<Either<String, String>> deleteTask(String userId, String taskId) async {
    try {
      await _taskRef.child(userId).child(taskId).remove();
      return Right('Task deleted');
    } catch (error) {
      return Left('Failed to delete task: $error');
    }
  }

  @override
  Future<Either<String, String>> createUser() async {
    try {
      // Get the current user count
      final snapshot = await _userCounterRef.get();
      final currentUserId = snapshot.exists && snapshot.value != null
          ? (snapshot.value as int)
          : 0;

      // Generate the new user ID
      final newUserId = 'user_${currentUserId + 1}';

      // Increment the user count in Firebase
      await _userCounterRef.set(currentUserId + 1);

      return Right(newUserId);
    } catch (error) {
      return Left('Failed to create user: $error');
    }
  }
}
