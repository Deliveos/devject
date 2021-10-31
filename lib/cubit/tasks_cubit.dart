import 'package:bloc/bloc.dart';
import 'package:devject/models/task.dart';

class TasksCubit extends Cubit<List<Task>> {
  TasksCubit() : super([]);

  Future<void> loadAll(int projectId) async {

  }
}
