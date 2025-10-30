import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/auth/widgets/apple/bloc/apple_event.dart';
import 'package:trendychef/Presentation/auth/widgets/apple/bloc/apple_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:trendychef/core/services/api/auth/apple.dart';

class AppleBloc extends Bloc<AppleEvent, AppleState> {
  AppleBloc() : super(AppleInitialState()) {
    on<AppleSignInEvent>((event, emit) async {
      emit(AppleLoadingState());
      try {
        final auth = FirebaseAuth.instance;
        UserCredential userCredential;

        if (kIsWeb) {
          final appleProvider = AppleAuthProvider();
          userCredential = await auth.signInWithPopup(appleProvider);
        } else {
          // You may need to handle iOS-specific sign-in using a package like `sign_in_with_apple`
          emit(AppleErrorState("Apple sign-in not implemented for non-web."));
          return;
        }

        final idToken = await userCredential.user?.getIdToken();
        if (idToken != null) {
          await userAppleAuthHandler(
            idToken,
            event.context,
          ); // your backend call
          emit(AppleSuccessState());
        } else {
          emit(AppleErrorState("Failed to get token"));
        }
      } catch (e) {
        emit(AppleErrorState("Sign in failed: ${e.toString()}"));
      }
    });
  }
}
