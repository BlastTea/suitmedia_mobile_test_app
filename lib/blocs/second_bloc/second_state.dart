part of '../blocs.dart';

@immutable
abstract class SecondState {}

class SecondInitial extends SecondState {}

class SecondError extends SecondState {}

class SecondDataLoaded extends SecondState {
  SecondDataLoaded({
    required this.scrollController,
    required this.users,
    required this.selectedUser,
    required this.currentPage,
    required this.totalPages,
    required this.isFetchingNextPage,
  });

  final ScrollController scrollController;

  final List<User> users;

  final User? selectedUser;

  final int currentPage;
  final int totalPages;

  final bool isFetchingNextPage;
}
