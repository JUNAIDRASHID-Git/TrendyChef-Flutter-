import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/auth/widgets/apple/bloc/apple_bloc.dart';
import 'package:trendychef/Presentation/auth/widgets/apple/bloc/apple_event.dart';
import 'package:trendychef/Presentation/auth/widgets/apple/bloc/apple_state.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppleBloc, AppleState>(
      builder: (context, state) {
        final isLoading = state is AppleLoadingState;

        return InkWell(
          onTap: isLoading
              ? null
              : () {
                  context
                      .read<AppleBloc>()
                      .add(AppleSignInEvent(context: context));
                },
          borderRadius: BorderRadius.circular(30),
          splashColor: const Color.fromARGB(255, 139, 139, 139),
          child: Container(
            width: 270,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromARGB(255, 32, 32, 32),
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset("assets/images/apple_logo.png"),
                        ),
                        const Text(
                          "Sign in with Apple",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
