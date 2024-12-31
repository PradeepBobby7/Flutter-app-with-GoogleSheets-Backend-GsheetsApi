import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsheet_app/bloc/events/auth_event.dart';
import 'package:gsheet_app/bloc/states/auth_state.dart';
import 'package:gsheet_app/repository/gsheet_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleSheetRepository repository;
  AuthBloc(this.repository) : super(AuthIntial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await repository.login(event.phoneNumber, event.password);
        if (user != null) {
          final products = await repository.getProducts();
          emit(AuthAuthenticated(user , products));
        } else {
          emit(const AuthError('Invalid PhoneNumber'));
        }
      } catch (e) {
        emit(AuthError('Login Failed:$e'));
      }
    });
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await repository.signUp(
            event.name, event.phoneNumber, event.password);
        if (user != null) {
          emit(AuthAuthenticated(user, []));
        } else {
          emit(const AuthError('Signip Failed'));
        }
      } catch (e) {
        emit(AuthError('Signup Failed: $e'));
      }
    });
  }
}



// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final GoogleSheetRepository repository;

//   AuthBloc(this.repository) : super(AuthIntial());

//   Stream<AuthState> mapEventToState(AuthEvent event) async* {
//     if (event is LoginEvent) {
//       yield AuthLoading();
//       try {
//         final user = await repository.login(event.phoneNumber, event.password);
//         if (user != null) {
//           final products = await repository.getProducts();
//           yield AuthAuthenticated(user as String, products);
//         } else {
//           yield const AuthError('Invalid Phonenumber or Password');
//         }
//       } catch (_) {
//         yield const AuthError('Login Failed');
//       }
//     } else if (event is SignUpEvent) {
//       yield AuthLoading();
//       try {
//         final user = await repository.signUp(
//             event.name, event.phoneNumber, event.password);
//         yield AuthAuthenticated(user as String, []);
//       } catch (_) {
//         yield const AuthError('SignedUp Failed');
//       }
//     }
//   }
// }
