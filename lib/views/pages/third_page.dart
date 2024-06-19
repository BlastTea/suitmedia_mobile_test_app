part of 'pages.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (MyApp.secondBloc.state is SecondInitial) {
      MyApp.secondBloc.add(InitializeSecondData());
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: navigatorKey.currentState?.pop,
          icon: const Icon(
            Icons.chevron_left,
            color: Color(0xFF554AF0),
            size: 32.0,
          ),
        ),
        title: const Text('Third Screen'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.sizeOf(context).width, 5.2),
          child: const Divider(
            height: 0.0,
          ),
        ),
      ),
      body: BlocBuilder<SecondBloc, SecondState>(
        builder: (context, stateSecond) {
          if (stateSecond is SecondDataLoaded) {
            if (stateSecond.users.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No data'),
                  const SizedBox(height: 8.0),
                  FilledButton.icon(
                    onPressed: () => MyApp.secondBloc.add(InitializeSecondData()),
                    label: const Text('Retry'),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              );
            }

            return RefreshIndicator(
              onRefresh: () {
                Completer<bool> completer = Completer();
                MyApp.secondBloc.add(InitializeSecondData(completer: completer));
                return completer.future;
              },
              child: ListView.builder(
                controller: stateSecond.scrollController,
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  if (index == stateSecond.users.length) {
                    if (!stateSecond.isFetchingNextPage) {
                      return Container();
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }

                  User user = stateSecond.users[index];

                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 48.0,
                          backgroundImage: CachedNetworkImageProvider(user.avatar),
                        ),
                        title: Text('${user.firstName} ${user.lastName}'),
                        titleTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
                        subtitle: Text(user.email),
                        contentPadding: EdgeInsets.zero,
                        onTap: () => MyApp.secondBloc.add(SetSelectedUser(user: user)),
                        selected: stateSecond.selectedUser == user,
                      ),
                      const Divider(thickness: 0.5),
                    ],
                  );
                },
                itemCount: stateSecond.users.length + 1,
              ),
            );
          } else if (stateSecond is SecondError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Error occured'),
                const SizedBox(height: 8.0),
                FilledButton.icon(
                  onPressed: () => MyApp.secondBloc.add(InitializeSecondData()),
                  label: const Text('Retry'),
                  icon: const Icon(Icons.refresh),
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
