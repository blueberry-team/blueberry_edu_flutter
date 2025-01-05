import 'package:flutter/material.dart';

class BlockingDemo extends StatefulWidget {
  const BlockingDemo({super.key});

  @override
  _BlockingDemoState createState() => _BlockingDemoState();
}

class _BlockingDemoState extends State<BlockingDemo> {
  int _counter = 0;
  bool _isCalculating = false;
  String _result = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // 블로킹 방식의 계산
  void _startBlockingCalculation() {
    setState(() {
      _isCalculating = true;
      _result = '계산 중...';
    });

    // 의도적으로 무거운 계산 수행 (약 3-5초 소요)
    int result = 0;
    for (int i = 0; i < 900000000; i++) {
      if (i % 2 == 0 && i % 3 == 0) {
        result += i;
      }
    }

    setState(() {
      _isCalculating = false;
      _result = '계산 완료: $result';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.withOpacity(0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '블로킹 방식',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          Text(
            '카운터: $_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          ElevatedButton(
            onPressed: _incrementCounter,
            child: const Text('카운터 증가'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isCalculating ? null : _startBlockingCalculation,
            child: const Text('무거운 계산 시작'),
          ),
          const SizedBox(height: 10),
          Text(_result),
        ],
      ),
    );
  }
}