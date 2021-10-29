import 'package:bloc/bloc.dart';
import 'package:devject/models/user.dart';
import 'package:devject/providers/user_provider.dart';


class UserCubit extends Cubit<User?> {
  UserCubit() : super(null) {
    load();
  }

  Future load() async {
    emit(await UserProvider.get());
  }

  Future update(User? user) async {
    emit(user);
  }
}
