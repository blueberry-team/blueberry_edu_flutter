import 'package:blueberry_edu/state/feature/check_count/check_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_edu/state/feature/get_profile_image/get_profile_image.dart';

final addCountProvider = StateProvider<int>((ref) => 0);

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(addCountProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Count: $count"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      ref.read(addCountProvider.notifier).state++;
                    },
                    child: const Text("UP!")),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CheckCount()));
                    },
                    child: const Text("이동")),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CheckCount()));
                    },
                    child: const Text("이동 완전히")),
              ],
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GetProfileImage()));
                },
                child: const Text("다음 페이지로")),
          ],
        ),
      ),
    );
  }
}

// class Home2 extends StatefulWidget {
//   const Home2({super.key});

//   @override
//   State<Home2> createState() => _Home2State();
// }

// class _Home2State extends State<Home2> {
//   int count = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home2'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Text("Count: $count"),
//             Row(
//               children: [
//                 TextButton(
//                     onPressed: () {
//                       setState(() {
//                         count++;
//                       });
//                     },
//                     child: const Text("UP!")),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Home3 extends StatelessWidget {
//   final counter = ValueNotifier<int>(0);
//   Home3({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home3'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             ValueListenableBuilder<int>(
//                 valueListenable: counter,
//                 builder: (context, value, child) {
//                   return Text("Count: $value");
//                 }),
//             TextButton(
//                 onPressed: () {
//                   counter.value++;
//                 },
//                 child: const Text("UP!")),
//           ],
//         ),
//       ),
//     );
//   }
// }
