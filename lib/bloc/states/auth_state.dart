import 'package:equatable/equatable.dart';
import 'package:gsheet_app/models/produce_model.dart';
import 'package:gsheet_app/models/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthIntial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  final List<Product> products;
  const AuthAuthenticated(this.user,this.products);

  @override
  List<Object?> get props => [user,products];
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
