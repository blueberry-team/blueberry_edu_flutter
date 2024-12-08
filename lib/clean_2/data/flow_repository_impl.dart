import 'package:blueberry_edu/clean_2/domain/flow_repository.dart';
import 'package:blueberry_edu/clean_2/provider/layer_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlowRepositoryImpl implements FlowRepository {
  final WidgetRef _ref;

  FlowRepositoryImpl(this._ref);

  @override
  Future<void> processDataTransfer(double amount) async {
    _ref.read(activeLayerProvider.notifier).setLayer("Data");
    await Future.delayed(const Duration(seconds: 1));
  }
}
