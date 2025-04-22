import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

// 애플리케이션의 진입점
void main() => runApp(const MyApp());

// StatelessWidget 생성
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = '웹소켓 데모';
    return MaterialApp(
      title: title, 
      home: const MyHomePage(title: title),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 상태 클래스: 위젯의 상태 관리
class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _clientIdController = TextEditingController(text: 'flutter_app');
  
  WebSocketChannel? _channel;
  bool _isConnected = false;
  final List<String> _messages = [];
  final ScrollController _scrollController = ScrollController();
  
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isConnected 
                        ? Colors.green 
                        : Theme.of(context).colorScheme.error,
                  ),
                ),
                const SizedBox(width: 8),
                Text(_isConnected ? "연결됨" : "연결 끊김"),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 클라이언트 ID 입력 필드와 연결 버튼
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _clientIdController,
                    decoration: const InputDecoration(
                      labelText: '클라이언트 ID',
                      border: OutlineInputBorder(),
                    ),
                    enabled: !_isConnected,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _isConnected ? _disconnectWebSocket : _connectToWebSocket,
                  child: Text(_isConnected ? '연결 끊기' : '연결'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // 연결 상태에 따라 메시지 입력/전송 UI 표시
            if (_isConnected) ...[
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _targetController,
                      decoration: const InputDecoration(
                        labelText: '대상 ID (비워두면 전체)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        labelText: '메시지 입력',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _sendMessage,
                    child: const Text('전송'),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 24),
            
            // 메시지 기록 표시
            Text(
              '메시지 기록:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                width: width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        _messages[index],
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _connectToWebSocket() {
    if (_clientIdController.text.isEmpty) {
      _addMessage('오류: 클라이언트 ID를 입력하세요.');
      return;
    }
    
    try {
      final clientId = _clientIdController.text.trim();
      
      // 경로에 클라이언트 ID를 포함
      _channel = WebSocketChannel.connect(
        Uri.parse('ws://10.0.2.2:8000/ws/$clientId'),
      );
      
      setState(() {
        _isConnected = true;
        _addMessage('서버에 연결 중... 클라이언트 ID: $clientId');
      });
      
      // 메시지 수신 리스너
      _channel!.stream.listen(
        (message) {
          setState(() {
            _addMessage('받음: $message');
          });
        },
        onError: (error) {
          setState(() {
            _isConnected = false;
            _addMessage('연결 오류: $error');
          });
        },
        onDone: () {
          setState(() {
            _isConnected = false;
            _addMessage('서버와 연결이 종료되었습니다.');
          });
        },
      );
    } catch (e) {
      setState(() {
        _isConnected = false;
        _addMessage('연결 실패: $e');
      });
    }
  }
  
  void _disconnectWebSocket() {
    if (_channel != null) {
      _channel!.sink.close();
      setState(() {
        _isConnected = false;
        _addMessage('서버와 연결을 종료했습니다.');
      });
    }
  }
  
  void _addMessage(String message) {
    setState(() {
      _messages.add('${DateTime.now().toString().substring(11, 19)} $message');
    });
    _scrollToBottom();
  }
  
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    if (_messageController.text.isEmpty || !_isConnected) return;
    
    final targetId = _targetController.text.trim();
    final messageText = _messageController.text;
    
    // JSON 형식으로 메시지 전송
    final jsonMessage = {
      'message': messageText,
    };
    
    if (targetId.isNotEmpty) {
      jsonMessage['target'] = targetId;
      _addMessage('전송 (to $targetId): $messageText');
    } else {
      _addMessage('전송 (전체): $messageText');
    }
    
    // JSON 문자열로 변환하여 전송
    _channel!.sink.add(jsonEncode(jsonMessage));
    _messageController.clear();
  }

  @override
  void dispose() {
    _channel?.sink.close();
    _messageController.dispose();
    _targetController.dispose();
    _clientIdController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
