// lib/bloc/task/task_state.dart
part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

class TasksInitial extends TaskState {}

class TasksLoadingState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TasksLoadSuccessState extends TaskState {
  final List<TaskModel> tasks;

  TasksLoadSuccessState({required this.tasks});
}

class TaskLoadSuccessState extends TaskState {
  final TaskModel? task;

  TaskLoadSuccessState({required this.task});
}

class TasksErrorState extends TaskState {
  final String error;

  TasksErrorState({required this.error});
}

class TaskErrorState extends TaskState {
  final String error;

  TaskErrorState({required this.error});
}

class TaskAddedState extends TaskState {}

class TaskUpdatedState extends TaskState {}

class TaskDeletedState extends TaskState {}

class TaskStatusUpdatedState extends TaskState {}
