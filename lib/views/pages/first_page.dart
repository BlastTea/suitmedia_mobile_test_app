part of 'pages.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<FirstBloc, FirstState>(
        builder: (context, stateFirst) {
          stateFirst as FirstDataLoaded;

          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  'assets/images/background.png',
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                Center(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Image.asset(
                        'assets/images/ic_photo.png',
                        width: 116.0,
                        height: 116.0,
                      ),
                      const SizedBox(height: 48.0),
                      TextField(
                        controller: stateFirst.textControllerName,
                        decoration: const InputDecoration(
                          hintText: 'Name',
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: stateFirst.textControllerPalindrome,
                        decoration: const InputDecoration(
                          hintText: 'Palindrome',
                        ),
                        onEditingComplete: () => MyApp.firstBloc.add(CheckButtonPressed()),
                      ),
                      const SizedBox(height: 48.0),
                      FilledButton(
                        onPressed: () => MyApp.firstBloc.add(CheckButtonPressed()),
                        child: const Text('CHECK'),
                      ),
                      const SizedBox(height: 16.0),
                      FilledButton(
                        onPressed: () {
                          currentName = stateFirst.textControllerName.text.trim();
                          if (currentName?.isEmpty ?? true) currentName = null;
                          navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => const SecondPage()));
                        },
                        child: const Text('NEXT'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
}
