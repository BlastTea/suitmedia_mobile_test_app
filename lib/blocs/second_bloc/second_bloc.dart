part of '../blocs.dart';

class SecondBloc extends Bloc<SecondEvent, SecondState> {
  SecondBloc() : super(SecondInitial()) {
    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_isFetchingNextPage) {
        add(InitializeSecondData(isFetchNextPage: true));
      }
    });

    on<SetSecondState>((event, emit) => emit(event.state ?? _secondDataLoaded));

    on<SetSecondToInitial>((event, emit) {
      _users.clear();

      _selectedUser = null;

      _currentPage = 1;

      _isFetchingNextPage = false;

      emit(SecondInitial());
    });

    on<InitializeSecondData>((event, emit) async {
      if (_isFetchingNextPage) return;

      if (!event.isFetchNextPage) {
        _users.clear();
        _currentPage = 1;
      }

      if (event.completer == null && !event.isFetchNextPage) emit(SecondInitial());

      if (event.isFetchNextPage) {
        if (_currentPage > _totalPages) return;
        _isFetchingNextPage = true;
        emit(_secondDataLoaded);
      }

      try {
        dynamic response = await ApiHelper.getUri(uri: Uri.parse('https://reqres.in/api/users?page=${_currentPage++}&per_page=10'));
        _users.addAll((response['data'] as List).map((e) => User.fromJson(e)).toList());
        _totalPages = response['total_pages'];
      } catch (e) {
        _isFetchingNextPage = false;
        event.completer?.complete(false);
        if (state is SecondDataLoaded) {
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(e.toString()),
              actions: [
                FilledButton(
                  onPressed: navigatorKey.currentState?.pop,
                  child: const Text('Ok'),
                ),
              ],
            ),
          );
          emit(_secondDataLoaded);
        } else {
          emit(SecondError());
        }
        return;
      }

      _isFetchingNextPage = false;
      event.completer?.complete(true);
      emit(_secondDataLoaded);
    });

    on<SetSelectedUser>((event, emit) {
      _selectedUser = event.user;
      emit(_secondDataLoaded);
      navigatorKey.currentState?.pop();
    });
  }

  final ScrollController _scrollController = ScrollController();

  final List<User> _users = [];

  User? _selectedUser;

  int _currentPage = 1;
  int _totalPages = 1;

  bool _isFetchingNextPage = false;

  SecondDataLoaded get _secondDataLoaded => SecondDataLoaded(
        scrollController: _scrollController,
        users: _users,
        selectedUser: _selectedUser,
        currentPage: _currentPage,
        totalPages: _totalPages,
        isFetchingNextPage: _isFetchingNextPage,
      );
}
