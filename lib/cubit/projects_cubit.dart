import 'package:bloc/bloc.dart';
import 'package:devject/models/project.dart';
import 'package:devject/services/api.dart';

class ProjectsCubit extends Cubit<List<Project>> {
  ProjectsCubit() : super([]);

  Future<void> load() async {
    emit(await API.getAllProjects());
  }

  Future<void> add(Project project) async {
    state.insert(0, project);
    emit(state);
  }
}
