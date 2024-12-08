import 'package:flutter_riverpod/flutter_riverpod.dart';

final balanceProvider = StateNotifierProvider<BalanceNotifier, double>((ref) {
  return BalanceNotifier();
});

class BalanceNotifier extends StateNotifier<double> {
  BalanceNotifier() : super(1000.0);

  void updateBalance(double newAmount) {
    state = newAmount;
  }
}
