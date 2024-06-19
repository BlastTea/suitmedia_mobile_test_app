part of '../blocs.dart';

@immutable
abstract class SecondEvent {}

class SetSecondState extends SecondEvent {
  SetSecondState([this.state]);

  final SecondState? state;
}

class SetSecondToInitial extends SecondEvent {}

class InitializeSecondData extends SecondEvent {
  InitializeSecondData({
    this.completer,
    this.isFetchNextPage = false,
  });

  final Completer<bool>? completer;
  final bool isFetchNextPage;
}

class SetSelectedUser extends SecondEvent {
  SetSelectedUser({required this.user});

  final User user;
}
