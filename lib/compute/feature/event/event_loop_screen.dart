import 'dart:async';

import 'package:flutter/material.dart';

class EventLoopScreen extends StatefulWidget {
  const EventLoopScreen({super.key});

  @override
  _EventLoopScreenState createState() => _EventLoopScreenState();
}

class _EventLoopScreenState extends State<EventLoopScreen> {
  List<String> logs = [];

  void addLog(String message) {
    setState(() {
      logs.add('${logs.length + 1}. $message');
    });
  }

  void runEventLoopTest() {
    // 로그 초기화
    setState(() {
      logs = [];
    });

    addLog('메인 시작');

    Future(() {
      addLog('이벤트 큐');
    });

    scheduleMicrotask(() {
      addLog('마이크로태스크 큐');
    });

    Future.microtask(() {
      addLog('Future.microtask');
    });

    addLog('메인 끝');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Event Loop 테스트'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: runEventLoopTest,
              child: const Text('이벤트 루프 테스트 시작'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    logs[index],
                    style: TextStyle(
                      color: _getColorForIndex(index),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForIndex(int index) {
    String log = logs[index].toLowerCase();
    if (log.contains('메인')) {
      return Colors.blue;
    } else if (log.contains('마이크로태스크')) {
      return Colors.green;
    } else if (log.contains('future.microtask')) {
      return Colors.purple;
    } else if (log.contains('이벤트')) {
      return Colors.red;
    }
    return Colors.black;
  }
}
