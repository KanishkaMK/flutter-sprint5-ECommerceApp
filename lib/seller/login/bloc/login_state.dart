part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class NavigateToHomeScreen extends LoginState {}

class LoginFailedState extends LoginState {}

class SellerNotExxistLoginFailedState extends LoginState {}
