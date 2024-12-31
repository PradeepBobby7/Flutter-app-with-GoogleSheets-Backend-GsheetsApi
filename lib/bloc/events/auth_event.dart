import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String phoneNumber;
  final String password;

  const LoginEvent(this.phoneNumber, this.password);

  @override
  List<Object?> get props => [phoneNumber, password];
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String phoneNumber;
  final String password;

  const SignUpEvent(this.name, this.phoneNumber,this.password);

  @override
  List<Object?> get props => [name, phoneNumber,password];
}
