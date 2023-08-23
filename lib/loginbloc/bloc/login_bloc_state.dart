part of 'login_bloc_bloc.dart';

// @immutable
// sealed class LoginBlocState {}
abstract class LoginblocState extends Equatable {
  const LoginblocState();

  @override
  List<Object> get props => [];
}

class LoginBlocInitialState extends LoginblocState {}
class LoginBlocLoadingState extends LoginblocState {}

class LoginBlocErrorState extends LoginblocState {
final String erroMessage ;
LoginBlocErrorState(this.erroMessage);

}

class LoginBlocPressedState extends LoginblocState {
  final Map<String,dynamic> response;
    LoginBlocPressedState({required this.response});
}

