import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/user.dart';
import 'services/get_users.dart';

// A Counter example implemented with riverpod

void main() {
  runApp(
    // Adding ProviderScope enables Riverpod for the entire project
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

/// Providers are declared globally and specify how to create a state
final userProvider = FutureProvider<List<User>?>((ref) async {
  final content = getUsers();
  return content;
});

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<User>?> config = ref.watch(userProvider);

    return Scaffold(
        appBar: AppBar(title: const Text('Counter example')),
        body: Container(
          child: config.when(
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => Text('Error: $err'),
            data: (config) {
              return ListView.builder(
                itemCount: config!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(config[index].name),
                    subtitle: Text(config[index].email),
                    leading: Text(config[index].id.toString()),
                  );
                },
              );
            },
          ),
        ));
  }
}
