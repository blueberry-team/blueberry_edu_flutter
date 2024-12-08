import 'package:blueberry_edu/clean_1/domain/counter_repository.dart';

class CounterUseCase {
  final CounterRepository repository;

  CounterUseCase(this.repository);

  void call() {
    final currentCounter = repository.getCounter();
    final updatedCounter =
        currentCounter.copyWith(value: currentCounter.value + 1);
    repository.updateCounter(updatedCounter);
  }
}
