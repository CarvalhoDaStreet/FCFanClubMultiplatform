import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fc_fan_club/features/auth/domain/repository/auth_repository.dart';
import 'package:fc_fan_club/features/auth/domain/entities/user.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class EmailSignInRequested extends AuthEvent {
  final String email;
  final String password;

  const EmailSignInRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class GoogleSignInRequested extends AuthEvent {}

class AppleSignInRequested extends AuthEvent {}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  const SignUpRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignOutRequested extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<EmailSignInRequested>(_onEmailSignInRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<AppleSignInRequested>(_onAppleSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onAuthCheckRequested(AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final isSignedIn = await authRepository.isSignedIn();
      if (isSignedIn) {
        final user = await authRepository.getCurrentUser();
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(Unauthenticated());
        }
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError('Authentication check failed: ${e.toString()}'));
    }
  }

  Future<void> _onEmailSignInRequested(EmailSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInWithEmail(event.email, event.password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(const AuthError('Email sign-in failed: Invalid credentials'));
      }
    } catch (e) {
      emit(AuthError('Email sign-in failed: ${e.toString()}'));
    }
  }

  Future<void> _onGoogleSignInRequested(GoogleSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInWithGoogle();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(const AuthError('Google sign-in failed: Unable to authenticate'));
      }
    } catch (e) {
      emit(AuthError('Google sign-in failed: ${e.toString()}'));
    }
  }

  Future<void> _onAppleSignInRequested(AppleSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInWithApple();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(const AuthError('Apple sign-in failed: Unable to authenticate'));
      }
    } catch (e) {
      emit(AuthError('Apple sign-in failed: ${e.toString()}'));
    }
  }

  Future<void> _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signUp(event.email, event.password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(const AuthError('Sign-up failed: Unable to create account'));
      }
    } catch (e) {
      emit(AuthError('Sign-up failed: ${e.toString()}'));
    }
  }

  Future<void> _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.signOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError('Sign out failed: ${e.toString()}'));
    }
  }
}
