import 'package:blueberry_edu/private_1/key/presenter/widgets/key_widget.dart';
import 'package:blueberry_edu/private_1/key/provider/key_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeyScreen extends ConsumerWidget {
  const KeyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = ref.watch(keyProvider(keyCounter));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Key Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('$key'),
            TextButton(
              onPressed: () {
                ref.read(keyProvider(keyCounter).notifier).state++;
              },
              child: const Text('add'),
            ),
            const KeyWidget(),
          ],
        ),
      ),
    );
  }
}
