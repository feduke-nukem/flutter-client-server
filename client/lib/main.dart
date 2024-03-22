import 'package:client/src/bloc/users_bloc.dart';
import 'package:client/src/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:shared/shared.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  Bloc.observer = _BlocObserver();
  final channel = ClientChannel(
    'localhost',
    port: 8080,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  );
  final client = UserServiceClient(channel);
  runApp(
    BlocProvider(
      create: (context) =>
          UsersBloc(UserService(client))..add(const UsersStarted()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MultiBlocListener(
          listeners: [
            BlocListener<UsersBloc, UsersState>(
              listener: (context, state) => _showSnack('User added'),
              listenWhen: (previous, current) =>
                  previous.users.length < current.users.length &&
                  previous is! UsersInitial,
            ),
            BlocListener<UsersBloc, UsersState>(
              listener: (context, state) => _showSnack('User deleted'),
              listenWhen: (previous, current) =>
                  previous.users.length > current.users.length,
            ),
            BlocListener<UsersBloc, UsersState>(
              listener: (context, state) => _showSnack('Error'),
              listenWhen: (previous, current) =>
                  previous.processingUsers.length >
                      current.processingUsers.length &&
                  current is UsersError,
            ),
            BlocListener<UsersBloc, UsersState>(
              listener: (context, state) => _showSnack('Success'),
              listenWhen: (previous, current) =>
                  previous.processingUsers.length >
                      current.processingUsers.length &&
                  current is! UsersError,
            ),
          ],
          child: BlocBuilder<UsersBloc, UsersState>(
            builder: (context, state) => switch (state) {
              UsersInitial() ||
              UsersLoading() =>
                const CircularProgressIndicator(),
              UsersError(users: []) => const Text('Error'),
              UsersIdle(users: []) => const Text('Empty'),
              UsersIdle() || UsersError() => RefreshIndicator(
                  onRefresh: () {
                    final bloc = context.read<UsersBloc>()
                      ..add(const UsersRefreshed());

                    return bloc.stream.first;
                  },
                  child: ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users.elementAt(index);

                      final isProcessing = state.processingUsers.contains(user);

                      final card = Card(
                        clipBehavior: Clip.hardEdge,
                        child: ListTile(
                          onTap: () async {
                            final usersBloc = context.read<UsersBloc>();
                            var name = user.name;
                            await showDialog<String>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Change user'),
                                content: TextFormField(
                                  validator: (value) => value?.isEmpty ?? false
                                      ? 'Name is required'
                                      : null,
                                  autovalidateMode: AutovalidateMode.always,
                                  onChanged: (value) => name = value,
                                  initialValue: name,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Confirm'),
                                  )
                                ],
                              ),
                            );

                            usersBloc.add(UserUpdated(id: user.id, name: name));
                          },
                          trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => context
                                  .read<UsersBloc>()
                                  .add(UserDeleted(id: user.id))),
                          title: Text(
                            user.name,
                            style: const TextStyle(color: Colors.black),
                          ),
                          subtitle: Text(user.id.toString()),
                        ),
                      );

                      return IgnorePointer(
                        ignoring: isProcessing,
                        child: isProcessing
                            ? Shimmer.fromColors(
                                enabled: true,
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: card,
                              )
                            : card,
                      );
                    },
                  ),
                ),
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final usersBloc = context.read<UsersBloc>();
          var name = '';
          await showDialog<String>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add user'),
              content: TextFormField(
                onChanged: (value) => name = value,
                validator: (value) =>
                    value?.isEmpty ?? false ? 'Name is required' : null,
                autovalidateMode: AutovalidateMode.always,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Confirm'),
                )
              ],
            ),
          );

          usersBloc.add(UserAdded(name: name));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showSnack(String text) => ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(content: Text(text)),
    );
}

class _BlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print(error);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print(change);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }
}
