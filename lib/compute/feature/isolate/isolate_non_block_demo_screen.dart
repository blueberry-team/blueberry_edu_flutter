import 'dart:isolate';
import 'package:flutter/material.dart';

class IsolateNonBlockingDemo extends StatefulWidget {
  const IsolateNonBlockingDemo({super.key});

  @override
  _IsolateNonBlockingDemoState createState() => _IsolateNonBlockingDemoState();
}

class _IsolateNonBlockingDemoState extends State<IsolateNonBlockingDemo> {
  int _counter = 0;
  bool _isCalculating = false;
  String _result = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // 논블로킹 방식의 계산 (Isolate 사용)
  Future<void> _startIsolateCalculation() async {
    setState(() {
      _isCalculating = true;
      _result = '계산 중...';
    });

    final receivePort = ReceivePort();

    try {
      // 새로운 Isolate 생성
      await Isolate.spawn(_heavyCalculation, receivePort.sendPort);

      // 결과 수신
      await for (final message in receivePort) {
        if (message is int) {
          setState(() {
            _isCalculating = false;
            _result = '계산 완료: $message';
          });
          break;
        }
        if (message is String && message == 'error') {
          setState(() {
            _isCalculating = false;
            _result = '계산 오류 발생';
          });
          break;
        }
      }
    } catch (e) {
      setState(() {
        _isCalculating = false;
        _result = '계산 오류: $e';
      });
    } finally {
      receivePort.close();
    }
  }

  // 무거운 계산 (Isolate 내부에서 실행)
  static void _heavyCalculation(SendPort sendPort) {
    try {
      int sum = 0;
      for (int i = 0; i < 900000000; i++) {
        if (i % 2 == 0 && i % 3 == 0) {
          sum += i;
        }
      }
      sendPort.send(sum); // 결과 전송
    } catch (e) {
      sendPort.send('error'); // 오류 전송
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.withOpacity(0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '논블로킹 방식 (Isolate)',
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
            onPressed: _isCalculating ? null : _startIsolateCalculation,
            child: const Text('무거운 계산 시작'),
          ),
          const SizedBox(height: 10),
          Text(_result),
        ],
      ),
    );
  }
}
