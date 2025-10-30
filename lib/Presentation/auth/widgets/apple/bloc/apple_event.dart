import 'package:flutter/material.dart';

abstract class AppleEvent {}

class AppleSignInEvent extends AppleEvent {
  final BuildContext context;
  AppleSignInEvent({required this.context});
}
