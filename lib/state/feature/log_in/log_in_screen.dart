import 'package:blueberry_edu/state/feature/home/home_screen.dart';
import 'package:blueberry_edu/state/data/auth/auth_repository.dart';
import 'package:blueberry_edu/state/feature/log_in/providers/userStateProvider.dart';
import 'package:blueberry_edu/state/feature/my_page/my_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({super.key});

  @override
  ConsumerState<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authRepository = ref.read(authRepositoryProvider);
    final userState = ref.watch(userStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("로그인"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "이메일",
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: "비밀번호",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await authRepository.logIn(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const MyPageScreen()));
                } catch (e) {
                  print(e);
                }
              },
              child: const Text("로그인"),
            ),
          ],
        ),
      ),
    );
  }
}
