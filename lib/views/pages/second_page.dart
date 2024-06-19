part of 'pages.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome', style: Theme.of(context).textTheme.bodySmall),
                  Text(currentName ?? 'Guest', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600)),
                ],
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
              FilledButton(
                onPressed: () => navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => const ThirdPage())),
                child: const Text('Choose a User'),
              ),
            ],
          ),
        ),
      );
}
