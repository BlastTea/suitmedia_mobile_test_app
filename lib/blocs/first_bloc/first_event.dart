part of '../blocs.dart';

@immutable
abstract class FirstEvent {}

class SetFirstState extends FirstEvent {
  SetFirstState([this.state]);

  final FirstState? state;
}

class CheckButtonPressed extends FirstEvent {}
