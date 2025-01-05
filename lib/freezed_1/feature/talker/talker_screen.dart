import 'package:blueberry_edu/freezed_1/feature/talker.dart';
import 'package:blueberry_edu/freezed_1/feature/talker/provider/input_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TalkerScreen extends ConsumerWidget {
  const TalkerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final inputState = ref.watch(inputStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: '이름',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: ageController,
              decoration: const InputDecoration(
                labelText: '나이',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                talkerInfo("TalkerScreen", "액션시작");
                ref.read(inputStateProvider.notifier).updateTalker(
                      nameController.text,
                      ageController.text,
                    );
              },
              child: const Text('저장'),
            ),
            const SizedBox(height: 24),
            if (inputState.talkerModel != null) ...[
              Text('변환된 이름: ${inputState.talkerModel!.name}'),
              Text('입력된 나이: ${inputState.talkerModel!.age}'),
            ],
          ],
        ),
      ),
    );
  }
}
