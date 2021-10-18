import 'package:bloc/bloc.dart';
import 'package:projetex/models/user.dart';
import 'package:projetex/providers/user_provider.dart';

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
