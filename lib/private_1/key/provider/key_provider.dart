import 'package:flutter_riverpod/flutter_riverpod.dart';

const keyCounter = 'key';

const keyCounter2 = 'key2';

final keyProvider = StateProvider.family<int, String>((ref, key) => 1);
