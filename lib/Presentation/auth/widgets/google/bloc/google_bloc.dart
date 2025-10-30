import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trendychef/core/services/api/auth/auth.dart';

part 'google_event.dart';
part 'google_state.dart';

class GoogleBloc extends Bloc<GoogleEvent, GoogleState> {
  // GoogleSignIn singleton (v7+)
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  bool _isInitialized = false;

  GoogleBloc() : super(GoogleInitial()) {
    on<GoogleSignInEvent>(_handleGoogleSignIn);
  }

  Future<void> _ensureInitialized() async {
    if (_isInitialized) return;

    // Initialize GoogleSignIn (v7+)
    await _googleSignIn.initialize();
    _isInitialized = true;
  }

  Future<void> _handleGoogleSignIn(
    GoogleSignInEvent event,
    Emitter<GoogleState> emit,
  ) async {
    emit(GoogleLoading());

    try {
      final auth = FirebaseAuth.instance;

      if (kIsWeb) {
        // Web sign-in
        final googleProvider = GoogleAuthProvider();
        googleProvider.addScope('email');
        googleProvider.setCustomParameters({'prompt': 'select_account'});

        final userCredential = await auth.signInWithPopup(googleProvider);

        final idToken = await userCredential.user?.getIdToken();
        if (idToken == null) throw Exception("Failed to retrieve token");

        await userGoogleAuthHandler(idToken, event.context);
        emit(GoogleLoaded(provider: "Google"));
      } else {
        // Mobile sign-in
        await _ensureInitialized();

        // authenticate() replaces signIn() in v7+
        final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
          scopeHint: const ['email', 'profile'],
        );

        final googleAuth = googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.idToken,
          idToken: googleAuth.idToken,
        );

        final userCredential = await auth.signInWithCredential(credential);

        final idToken = await userCredential.user?.getIdToken();
        if (idToken == null) throw Exception("Failed to retrieve token");

        await userGoogleAuthHandler(idToken, event.context);
        emit(GoogleLoaded(provider: "Google"));
      }
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        emit(GoogleError(error: "Login cancelled by user."));
      } else {
        emit(
          GoogleError(
            error:
                "Google Sign-In error: ${e.code.name} ${e.description ?? ''}",
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      emit(GoogleError(error: "Firebase Auth Error: ${e.message}"));
    } catch (e) {
      debugPrint("Google sign-in error: $e");
      emit(GoogleError(error: "Google sign-in failed"));
    }
  }
}
