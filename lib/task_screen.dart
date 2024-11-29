import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'task/bloc/task_bloc.dart';

import 'task_model.dart';

class TaskScreen extends StatefulWidget {
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    TaskBloc.tasksBloc.add(LoadTasksEvent());
    super.initState();
  }

  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do App')),
      body: BlocBuilder<TaskBloc, TaskState>(
        bloc: TaskBloc.tasksBloc,
        builder: (context, state) {
          if (state is TasksLoadingState) {
            // return Center(child: CircularProgressIndicator());
          } else if (state is TasksLoadSuccessState) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(task.isCompleted
                        ? Icons.check_box
                        : Icons.check_box_outline_blank),
                    onPressed: () {
                      // Toggle the isCompleted property
                      final updatedTask = task.copyWith(
                        isCompleted: !task.isCompleted,
                      );

                      // Trigger an EditTaskEvent with the updated task
                      TaskBloc.tasksBloc.add(
                        EditTaskEvent(
                            taskId: task.id, updatedTask: updatedTask),
                      );
                    },
                  ),
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm Deletion'),
                          content: const Text(
                              'Are you sure you want to delete this task?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Close the dialog without taking any action
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Delete the task and close the dialog
                                TaskBloc.tasksBloc
                                    .add(DeleteTaskEvent(taskId: task.id));
                                Navigator.of(context).pop();
                              },
                              child: const Text('Delete',
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          } else if (state is TaskErrorState) {
            return Center(child: Text(state.error));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Task'),
        content: TextField(
          controller: _taskController,
          decoration: const InputDecoration(hintText: 'Enter task title'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final task = TaskModel(
                id: '',
                title: _taskController.text,
                isCompleted: false,
              );
              TaskBloc.tasksBloc.add(AddTaskEvent(task: task));
              _taskController.clear();
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
