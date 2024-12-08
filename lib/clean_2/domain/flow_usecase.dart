import 'package:blueberry_edu/clean_2/data/flow_repository_impl.dart';
import 'package:blueberry_edu/clean_2/domain/flow_repository.dart';
import 'package:blueberry_edu/clean_2/provider/layer_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlowUseCase {
  final WidgetRef _ref;
  final FlowRepository _repository;

  FlowUseCase(this._ref) : _repository = FlowRepositoryImpl(_ref);

  Future<double> processDomainTransfer(double amount) async {
    // Domain layer logic
    _ref.read(activeLayerProvider.notifier).setLayer("Domain");
    await Future.delayed(const Duration(seconds: 1));

    // Call data layer
    await _repository.processDataTransfer(amount);

    // Return to domain for processing
    _ref.read(activeLayerProvider.notifier).setLayer("Domain");
    await Future.delayed(const Duration(seconds: 1));

    return amount - 100; // Process the transfer
  }
}
