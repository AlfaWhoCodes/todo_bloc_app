import 'package:cloud_firestore/cloud_firestore.dart';
import 'task_model.dart';

class TaskRepository {
  final FirebaseFirestore _firestore;

  TaskRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference get tasksRef => _firestore.collection('tasks');
  Future<List<TaskModel>> getTaskList() async {
    final querySnapshot = await tasksRef
        // Fetch all tasks
        .get();
    return querySnapshot.docs
        .map((doc) => TaskModel.fromDocument(doc))
        .toList();
  }

  Future<void> addTask(TaskModel task) async {
    try {
      await tasksRef.add(task.toMap());
    } catch (e) {
      throw Exception("Error adding task: $e");
    }
  }

  Future<void> editTask(String taskId, TaskModel updatedTask) async {
    try {
      await tasksRef.doc(taskId).update(updatedTask.toMap());
    } catch (e) {
      throw Exception("Error editing task: $e");
    }
  }

  // Update an existing task
  Future<void> updateTask(TaskModel task) async {
    await _firestore.collection('tasks').doc(task.id).update(task.toMap());
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }
}
