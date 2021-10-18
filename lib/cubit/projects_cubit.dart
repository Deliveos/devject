import 'package:bloc/bloc.dart';
import 'package:projetex/models/project.dart';
import 'package:projetex/services/projetex_api.dart';

class ProjectsCubit extends Cubit<List<Project>?> {
  ProjectsCubit() : super([]);

  Future<void> load() async {
    emit(await ProjetexApi.getAllProjects());
  }

  Future<void> update(Project project) async {
    state!.add(project);
    emit(state);
    
  }
}
