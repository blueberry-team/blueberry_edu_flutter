import 'package:blueberry_edu/state/feature/sign_up/providers/sign_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController activityController = TextEditingController();

  SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  @override
  void dispose() {
    widget.emailController.dispose();
    widget.passwordController.dispose();
    widget.nameController.dispose();
    widget.activityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("회원가입"),
      ),
      body: Column(
        children: [
          TextField(
            controller: widget.emailController,
            decoration: const InputDecoration(
              labelText: '이메일',
            ),
          ),
          TextField(
            controller: widget.passwordController,
            decoration: const InputDecoration(
              labelText: '비밀번호',
            ),
          ),
          TextField(
            controller: widget.nameController,
            decoration: const InputDecoration(
              labelText: '이름',
            ),
          ),
          TextField(
            controller: widget.activityController,
            decoration: const InputDecoration(
              labelText: '취미',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              ref.read(signUpProvider.notifier).signUp(
                    email: widget.emailController.text,
                    password: widget.passwordController.text,
                    name: widget.nameController.text,
                    activity: widget.activityController.text,
                  );
            },
            child: const Text("회원가입"),
          ),
        ],
      ),
    );
  }
}
