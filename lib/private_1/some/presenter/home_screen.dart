part of '../some.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final some = ref.watch(_someProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            const HomeWidget(),
            Text('$some'),
            TextButton(
              onPressed: () {
                ref.read(_someProvider.notifier).state++;
              },
              child: const Text('add'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const KeyScreen()));
                },
                child: const Text('move')),
          ],
        ),
      ),
    );
  }
}
