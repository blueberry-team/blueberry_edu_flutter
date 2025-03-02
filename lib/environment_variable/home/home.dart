import 'package:blueberry_edu/environment_variable/env/env.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Key: ${Env.key}'),
            Text('Password: ${Env.password}'),
          ],
        ),
      ),
    );
  }
}
