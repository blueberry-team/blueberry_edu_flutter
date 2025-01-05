import 'package:blueberry_edu/compute/feature/block/block_demo_screen.dart';
import 'package:blueberry_edu/compute/feature/isolate/isolate_non_block_demo_screen.dart';
import 'package:blueberry_edu/compute/feature/non_block/non_block_demo_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UI Blocking 비교')),
      body: const Row(
            children: [
              Expanded(child: BlockingDemo()),
              VerticalDivider(thickness: 2),
              Expanded(child: NonBlockingDemo()),
              VerticalDivider(thickness: 2),
              Expanded(child: IsolateNonBlockingDemo()),
            ],
          ),
    );
  }
}
