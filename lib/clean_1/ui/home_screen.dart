import 'package:blueberry_edu/clean_1/data/counter_repository_impl.dart';
import 'package:blueberry_edu/clean_1/domain/counter_usecase.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final CounterUseCase _incrementCounterUseCase;
  late int _counterValue;

  @override
  void initState() {
    super.initState();
    final repository = CounterRepositoryImpl();
    _incrementCounterUseCase = CounterUseCase(repository);
    _counterValue = repository.getCounter().value;
  }

  void _incrementCounter() {
    _incrementCounterUseCase.call();
    setState(() {
      _counterValue++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Demo with Clean Architecture"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counterValue',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
