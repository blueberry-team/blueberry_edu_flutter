import 'package:blueberry_edu/private_1/key/provider/key_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeyWidget extends ConsumerWidget {
  const KeyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = ref.watch(keyProvider(keyCounter2));
    return Text('$key');
  }
}
