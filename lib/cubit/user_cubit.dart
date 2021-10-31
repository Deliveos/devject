import 'package:bloc/bloc.dart';
import 'package:devject/models/user.dart';
import 'package:devject/providers/user_provider.dart';
import 'package:devject/services/api.dart';


class UserCubit extends Cubit<User?> {
  UserCubit() : super(null) {
    load();
  }

  Future load() async {
    emit(await UserProvider.get());
  }

  Future update(User user) async {
    emit(user);
    await UserProvider.update(user);
    await API.updateUser(user);
  }
}
