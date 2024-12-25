import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task/domain/usecase/add_task.dart';
import 'package:task_manager/features/task/domain/usecase/delete_task.dart';
import 'package:task_manager/features/task/domain/usecase/edit_task.dart';
import 'package:task_manager/features/task/domain/usecase/fetch_task.dart';
import 'package:task_manager/features/task/domain/usecase/create_user.dart';
import 'package:task_manager/features/task/presentation/bloc/task_event.dart';
import 'package:task_manager/features/task/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final FetchTasks fetchTasks;
  final AddTask addTask;
  final EditTask editTask;
  final DeleteTask deleteTask;
  final CreateUser createUser;

  TaskBloc({
    required this.fetchTasks,
    required this.addTask,
    required this.editTask,
    required this.deleteTask,
    required this.createUser,
  }) : super(TaskInitial()) {
    on<FetchTasksEvent>(_onFetchTasks);
    on<AddTaskEvent>(_onAddTask);
    on<EditTaskEvent>(_onEditTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<CreateUserEvent>(_onCreateUser);
  }

  Future<void> _onFetchTasks(FetchTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final res = await fetchTasks.call(event.userId);
    res.fold(
      (l) => emit(TaskError(message: l)),
      (r) { 
        print(r.length);
        emit(TaskLoaded(tasks: r));
      },
    );
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final res = await addTask.call(event.userId, event.task);
    res.fold(
      (l) => emit(TaskError(message: l)),
      (r) { 
        print(r.dueDate);
        emit(TaskAdded(task: r));
      },
    );
  }

  Future<void> _onEditTask(EditTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final res = await editTask.call(event.userId, event.taskId, event.task);
    res.fold(
      (l) => emit(TaskError(message: l)),
      (r) => emit(TaskEdited(task: r)),
    );
  }

  Future<void> _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final res = await deleteTask.call(event.userId, event.taskId);
    res.fold(
      (l) => emit(TaskError(message: l)),
      (r) => emit(TaskDeleted()),
    );
  }

  Future<void> _onCreateUser(CreateUserEvent event, Emitter<TaskState> emit) async {
    final result = await createUser.call();
    result.fold(
      (l) => emit(TaskError(message: l)),
      (r) { 

        print("right in creat user");
        print(r);
        emit(TaskUserCreated(userId: r));
      
      },
    );
  }
}
