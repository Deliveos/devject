import 'package:bloc/bloc.dart';
import 'package:devject/models/user.dart';

class ResponsibleCubit extends Cubit<List<User>> {
  ResponsibleCubit() : super([]);

  void add(User user) {
    state.add(user);
    emit(state);
  }

  void remove(int id) {
    final List<User> newState = [];
    for (User user in state) {
      if (user.id != id) {
        newState.add(user);
      }
    }
    emit(newState);
    // state.removeWhere((User user) => user.id==id);
    // emit(state);
  }
}
