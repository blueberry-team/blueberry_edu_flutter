import 'package:blueberry_edu/state/feature/my_page/providers/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnotherMyPage extends ConsumerWidget {
  const AnotherMyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Page2'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(userInfo.userModel?.name ?? ''),
            Text(userInfo.userModel?.activity ?? ''),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
