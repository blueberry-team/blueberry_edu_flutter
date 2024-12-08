import 'package:blueberry_edu/clean_1/model/counter_model.dart';

abstract class CounterRepository {
  CounterModel getCounter();

  void updateCounter(CounterModel counter);
}
