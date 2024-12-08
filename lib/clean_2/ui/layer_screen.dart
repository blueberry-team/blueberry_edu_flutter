import 'package:blueberry_edu/clean_2/domain/flow_usecase.dart';
import 'package:blueberry_edu/clean_2/provider/balance_provider.dart';
import 'package:blueberry_edu/clean_2/provider/layer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LayerScreen extends ConsumerStatefulWidget {
  const LayerScreen({super.key});

  @override
  ConsumerState<LayerScreen> createState() => _LayerScreenState();
}

class _LayerScreenState extends ConsumerState<LayerScreen> {
  late final FlowUseCase _flowUseCase;

  @override
  void initState() {
    super.initState();
    _flowUseCase = FlowUseCase(ref);
  }

  Future<void> _startTransfer() async {
    // UI Layer
    ref.read(activeLayerProvider.notifier).setLayer("UI");
    await Future.delayed(const Duration(seconds: 1));

    // Process in domain layer
    final currentBalance = ref.read(balanceProvider);
    final newAmount = await _flowUseCase.processDomainTransfer(currentBalance);

    // Back to UI
    ref.read(activeLayerProvider.notifier).setLayer("UI");
    ref.read(balanceProvider.notifier).updateBalance(newAmount);
  }

  Widget _buildLayer(String layerName, Color color) {
    final isActive = ref.watch(activeLayerProvider) == layerName;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isActive ? Colors.red : Colors.transparent,
          width: 3,
        ),
      ),
      width: 200,
      height: 100,
      child: Center(
        child: Text(
          layerName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final currentBalance = ref.watch(balanceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Architecture Flow Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLayer("UI", Colors.grey[300]!),
            _buildLayer("Domain", Colors.grey[300]!),
            _buildLayer("Data", Colors.grey[300]!),
            const SizedBox(height: 20),
            Text(
              "Amount: \$${currentBalance.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startTransfer,
              child: const Text("Start Transfer"),
            ),
          ],
        ),
      ),
    );
  }
}
