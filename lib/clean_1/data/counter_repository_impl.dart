import 'package:blueberry_edu/clean_1/domain/counter_repository.dart';
import 'package:blueberry_edu/clean_1/model/counter_model.dart';

class CounterRepositoryImpl implements CounterRepository {
  CounterModel _counter = const CounterModel(value: 0);

  @override
  CounterModel getCounter() {
    return _counter;
  }

  @override
  void updateCounter(CounterModel counter) {
    _counter = counter;
  }
}
