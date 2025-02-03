part of '../../some.dart';

class HomeWidget extends ConsumerWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final some = ref.watch(_someProvider);
    return Text(
      '$some',
    );
  }
}
