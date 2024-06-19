part of '../blocs.dart';

@immutable
abstract class FirstState {}

class FirstDataLoaded extends FirstState {
  FirstDataLoaded({
    required this.textControllerName,
    required this.textControllerPalindrome,
  });

  final TextEditingController textControllerName;
  final TextEditingController textControllerPalindrome;
}
