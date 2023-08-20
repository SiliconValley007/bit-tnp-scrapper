part of 'cookie_cubit.dart';

sealed class CookieState extends Equatable {
  const CookieState();

  @override
  List<Object> get props => [];
}

final class CookieInitial extends CookieState {}
final class NoLoginDataFound extends CookieState {}
final class LoginDataFound extends CookieState {}
final class ErrorLoggingIn extends CookieState {}

