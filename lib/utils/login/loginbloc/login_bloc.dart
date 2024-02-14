import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/utils/constant/constants.dart';
import 'package:my_app/utils/login/loginbloc/login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(IntialState()) {
    getLocalData();
    print('object object object object');
    checkuserloginornot();
  }

  void checkuserloginornot() async {
    print('Entered in checkuserloginornot function');

    await Future.delayed(
      Duration(
        seconds: 2,
      ),
    );
    print('user type is in login bloc.dart file is $uType');
    print('user id is in login bloc.dart file is $uId');
    if (uType.isEmpty || uId.isEmpty) {
      emit(UsernotLoginState());
      print(state);
    }
    if (uType.isNotEmpty && uId.isNotEmpty) {
      emit(UserLoginState());
      print(state);
    }
  }
}
