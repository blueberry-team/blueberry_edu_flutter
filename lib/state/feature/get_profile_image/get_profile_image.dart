import 'dart:convert';
import 'package:blueberry_edu/state/feature/log_in/log_in_screen.dart';
import 'package:blueberry_edu/state/feature/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final usernameProvider = StateProvider<String>((ref) => "");

final searchTriggerProvider = StateProvider<bool>((ref) => false);

final githubProfileProvider = FutureProvider<String>((ref) async {
  final username = ref.watch(usernameProvider);
  final search = ref.watch(searchTriggerProvider);

  final response = await http.get(
    Uri.parse("https://api.github.com/users/$username"),
  );

  if (!search || username.isEmpty) {
    return "";
  }

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['avatar_url'] as String;
  } else {
    throw Exception("Failed to load profile");
  }
});

class GetProfileImage extends ConsumerStatefulWidget {
  final TextEditingController idController = TextEditingController();
  GetProfileImage({super.key});

  @override
  ConsumerState<GetProfileImage> createState() => _GetProfileImageState();
}

class _GetProfileImageState extends ConsumerState<GetProfileImage> {
  @override
  void dispose() {
    widget.idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("프로필 이미지 가져오기"),
      ),
      body: Column(
        children: [
          TextField(controller: widget.idController),
          ElevatedButton(
            onPressed: () {
              ref.read(usernameProvider.notifier).state =
                  widget.idController.text;
              ref.read(searchTriggerProvider.notifier).state = true;
            },
            child: const Text("가져오기"),
          ),
          Consumer(
            builder: (context, ref, child) {
              final myProfileImage = ref.watch(githubProfileProvider);
              return myProfileImage.when(
                data: (imageUrl) {
                  if (imageUrl.isEmpty) {
                    return const Center(
                      child: Text("이미지가 없습니다."),
                    );
                  }
                  return Image.network(imageUrl);
                },
                error: (error, stackTrace) => Text("Error: $error"),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
            child: const Text("회원가입"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LogInScreen()));
            },
            child: const Text("로그인"),
          ),
        ],
      ),
    );
  }
}
