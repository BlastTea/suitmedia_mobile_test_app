part of 'pages.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int _currentSecond = 5;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSecond <= 0) {
        timer.cancel();
      }

      if (_currentSecond > 0) {
        _currentSecond--;
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: navigatorKey.currentState?.pop,
            icon: const Icon(
              Icons.chevron_left,
              color: Color(0xFF554AF0),
              size: 32.0,
            ),
          ),
          title: const Text('Second Screen'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.sizeOf(context).width, 5.2),
            child: const Divider(
              height: 0.0,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome', style: Theme.of(context).textTheme.bodySmall),
                  Text(currentName ?? 'Guest', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            if (_currentSecond > 0)
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SizedBox(
                  height: 200.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Flash Sale 00:00:$_currentSecond'),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Row(
                            children: [
                              Container(
                                width: 150.0,
                                height: 200.0,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Center(
              child: BlocBuilder<SecondBloc, SecondState>(
                builder: (context, stateSecond) {
                  String selected = 'Selected User Name';

                  if (stateSecond is SecondDataLoaded && stateSecond.selectedUser?.firstName != null && stateSecond.selectedUser?.lastName != null) {
                    selected = '${stateSecond.selectedUser!.firstName} ${stateSecond.selectedUser!.lastName}';
                  }

                  return Text(selected, style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600));
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FilledButton(
            onPressed: () => navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => const ThirdPage())),
            child: const Text('Choose a User'),
          ),
        ),
      );
}
