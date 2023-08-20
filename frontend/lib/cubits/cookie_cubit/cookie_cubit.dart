import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/local_storage_manager.dart';
import '../../network/network_calls.dart';

part 'cookie_state.dart';

class CookieCubit extends Cubit<CookieState> {
  CookieCubit() : super(CookieInitial()) {
    _loadCookie();
  }

  static bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void _loadCookie() {
    final String? cookie = LocalStorage.getCookie();
    if (cookie == null) {
      emit(NoLoginDataFound());
    } else {
      _isLoggedIn = true;
      emit(LoginDataFound());
    }
  }

  void login({required String username, required String password}) async {
    final int? result =
        await Network.login(username: username, password: password);
    if (result == 200) {
      _loadCookie();
      _isLoggedIn = true;
      emit(LoginDataFound());
    } else {
      emit(ErrorLoggingIn());
    }
  }
}
