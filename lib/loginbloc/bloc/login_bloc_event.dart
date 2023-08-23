part of 'login_bloc_bloc.dart';

@immutable
sealed class LoginBlocEvent {}
class LoginButtonPressedEvent extends  LoginBlocEvent{
 final String  ? email;
  final String ? password;
  LoginButtonPressedEvent({this.email, this.password});


}