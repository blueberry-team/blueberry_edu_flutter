import 'package:blueberry_edu/state/feature/my_page/another_my_page.dart';
import 'package:blueberry_edu/state/feature/my_page/providers/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(userInfoProvider.notifier).getUserInfo(),
      builder: (context, snapshot) {
        final userInfo = ref.watch(userInfoProvider).userModel;

        return Scaffold(
          appBar: AppBar(
            title: const Text('My Page'),
          ),
          body: userInfo == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Text('이메일: ${userInfo.email}'),
                    Text('이름: ${userInfo.name}'),
                    Text('취미: ${userInfo.activity}'),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AnotherMyPage()),
                        );
                      },
                      child: const Text('Another My Page'),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
