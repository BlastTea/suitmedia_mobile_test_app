part of '../blocs.dart';

class FirstBloc extends Bloc<FirstEvent, FirstState> {
  FirstBloc() : super(_firstDataLoaded) {
    on<SetFirstState>((event, emit) => emit(event.state ?? _firstDataLoaded));

    on<CheckButtonPressed>((event, emit) {
      if (_textControllerPalindrome.text.trim().isEmpty) {
        scaffoldMessengerKey.currentState!.clearSnackBars();
        scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(content: Text('Palindrome is still empty')));
        return;
      }

      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
          title: Text(isPalindrome(_textControllerPalindrome.text.trim()) ? 'isPalindrome' : 'not palindrome'),
          actions: [
            FilledButton(
              onPressed: navigatorKey.currentState?.pop,
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    });
  }

  static final TextEditingController _textControllerName = TextEditingController();
  static final TextEditingController _textControllerPalindrome = TextEditingController();

  static get _firstDataLoaded => FirstDataLoaded(
        textControllerName: _textControllerName,
        textControllerPalindrome: _textControllerPalindrome,
      );

  bool isPalindrome(String text) {
    String cleanedText = text.replaceAll(' ', '').toLowerCase();
    return cleanedText == cleanedText.split('').reversed.join('');
  }
}
