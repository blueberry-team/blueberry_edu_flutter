import 'package:flutter_riverpod/flutter_riverpod.dart';

final activeLayerProvider = StateNotifierProvider<ActiveLayerNotifier, String>((ref) {
  return ActiveLayerNotifier();
});

class ActiveLayerNotifier extends StateNotifier<String> {
  ActiveLayerNotifier() : super('UI');

  void setLayer(String layer) {
    state = layer;
  }
}
