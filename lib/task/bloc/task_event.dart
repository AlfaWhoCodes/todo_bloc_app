// lib/bloc/task/task_event.dart
part of 'task_bloc.dart';

sealed class TaskEvent {}

class LoadTasksEvent extends TaskEvent {}

class LoadTaskEvent extends TaskEvent {
  final String taskId;

  LoadTaskEvent({required this.taskId});
}

class AddTaskEvent extends TaskEvent {
  final TaskModel task;

  AddTaskEvent({required this.task});
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  DeleteTaskEvent({required this.taskId});
}

class EditTaskEvent extends TaskEvent {
  final TaskModel updatedTask;
  final String taskId;

  EditTaskEvent({required this.taskId, required this.updatedTask});
}

class UpdateTaskStatusEvent extends TaskEvent {
  final String taskId;
  final String status;

  UpdateTaskStatusEvent({
    required this.taskId,
    required this.status,
  });
}
