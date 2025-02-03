import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

int heavyCalculation(int maxNumber) {
  int sum = 0;
  for (int i = 0; i < maxNumber; i++) {
    if (i % 2 == 0 && i % 3 == 0) {
      sum += i;
    }
  }
  return sum;
}

class NonBlockingDemo extends StatefulWidget {
  const NonBlockingDemo({super.key});

  @override
  _NonBlockingDemoState createState() => _NonBlockingDemoState();
}

class _NonBlockingDemoState extends State<NonBlockingDemo> {
  int _counter = 0;
  bool _isCalculating = false;
  String _result = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // 논블로킹 방식의 계산 (compute 사용)
  Future<void> _startNonBlockingCalculation() async {
    setState(() {
      _isCalculating = true;
      _result = '계산 중...';
    });

    try {
      final result = await compute<void, int>((_) {
        int sum = 0;
        for (int i = 0; i < 900000000; i++) {
          if (i % 2 == 0 && i % 3 == 0) {
            sum += i;
          }
        }
        return sum;
      }, null);

      // final result = await compute(heavyCalculation, 900000000);

      setState(() {
        _isCalculating = false;
        _result = '계산 완료: $result';
      });
    } catch (e) {
      setState(() {
        _isCalculating = false;
        _result = '계산 오류: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.withOpacity(0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '논블로킹 방식 (compute)',
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
            onPressed: _isCalculating ? null : _startNonBlockingCalculation,
            child: const Text('무거운 계산 시작'),
          ),
          const SizedBox(height: 10),
          Text(_result),
        ],
      ),
    );
  }
}
