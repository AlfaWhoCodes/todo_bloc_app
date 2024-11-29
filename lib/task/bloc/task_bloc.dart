import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_bloc_app/task_model.dart';
import 'package:todo_bloc_app/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  static TaskBloc taskBloc = TaskBloc();
  static TaskBloc tasksBloc = TaskBloc();

  TaskBloc() : super(TasksInitial()) {
    on<LoadTasksEvent>(_onFetchTasks);
    on<AddTaskEvent>(_onAddTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<EditTaskEvent>(_onEditTask);
  }

  Future<void> _onFetchTasks(
    LoadTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      final tasks = await TaskRepository().getTaskList();
      emit(TasksLoadSuccessState(tasks: tasks));
    } catch (e) {
      emit(TasksErrorState(error: e.toString()));
    }
  }

  Future<void> _onAddTask(
    AddTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await TaskRepository().addTask(event.task);
      add(LoadTasksEvent()); // Refresh the task list after adding
    } catch (e) {
      emit(TasksErrorState(error: e.toString()));
    }
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await TaskRepository().deleteTask(event.taskId);
      add(LoadTasksEvent()); // Refresh the task list after deleting
    } catch (e) {
      emit(TasksErrorState(error: e.toString()));
    }
  }

  Future<void> _onEditTask(
    EditTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      // Call the TaskRepository to edit the task in Firestore
      await TaskRepository().editTask(event.taskId, event.updatedTask);

      // Optionally refresh the task list to reflect the updated task
      add(LoadTasksEvent()); // Refresh the task list after editing
    } catch (e) {
      // Emit an error state if something goes wrong
      emit(TasksErrorState(error: e.toString()));
    }
  }
}
