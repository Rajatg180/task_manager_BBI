import 'package:get_it/get_it.dart';
import 'package:task_manager/features/task/data/datasource/remote/remote_data_source.dart';
import 'package:task_manager/features/task/data/repository/repository_implementation.dart';
import 'package:task_manager/features/task/domain/repositories/task_repository.dart';
import 'package:task_manager/features/task/domain/usecase/add_task.dart';
import 'package:task_manager/features/task/domain/usecase/fetch_task.dart';
import 'package:task_manager/features/task/domain/usecase/edit_task.dart';
import 'package:task_manager/features/task/domain/usecase/delete_task.dart';
import 'package:task_manager/features/task/domain/usecase/create_user.dart';
import 'package:task_manager/features/task/presentation/bloc/task_bloc.dart';

final sl = GetIt.instance; // This is the service locator instance

void init() {
  // Registering RemoteDataSource
  sl.registerLazySingleton<TaskRemoteDataSource>(() => TaskRemoteDataSourceImpl());

  // Registering Repository Implementation
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(taskRemoteDataSource: sl()));

  // Registering UseCases
  sl.registerLazySingleton<FetchTasks>(() => FetchTasks(taskRepository: sl()));
  sl.registerLazySingleton<AddTask>(() => AddTask(taskRepository: sl()));
  sl.registerLazySingleton<EditTask>(() => EditTask(taskRepository: sl()));
  sl.registerLazySingleton<DeleteTask>(() => DeleteTask(taskRepository: sl()));
  sl.registerLazySingleton<CreateUser>(() => CreateUser(taskRepository: sl()));

  // Registering TaskBloc
  sl.registerFactory<TaskBloc>(() => TaskBloc(
    fetchTasks: sl(),
    addTask: sl(),
    editTask: sl(),
    deleteTask: sl(),
    createUser: sl(),
  ));
}
