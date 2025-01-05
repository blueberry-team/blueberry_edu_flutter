import 'package:blueberry_edu/freezed_1/feature/model/basic_model.dart';
import 'package:blueberry_edu/freezed_1/feature/model/freezed_model.dart';
import 'package:flutter/material.dart';

class FreezedHome extends StatefulWidget {
  const FreezedHome({super.key});

  @override
  State<FreezedHome> createState() => _FreezedHomeState();
}

class _FreezedHomeState extends State<FreezedHome> {
  Widget modelText(String title, String text) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final basicModel = BasicModel(name: "재혁", country: "한국");
    final basicModel2 = BasicModel(name: "재혁", country: "한국");
    const freezedModel = FreezedModel(name: "정우", country: "일본");
    const freezedModel2 = FreezedModel(name: "정우", country: "일본");
    final freezedModel3 = freezedModel.copyWith(name: "한규");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Freezed'),
      ),
      body: Column(
        children: [
          modelText("Basic", basicModel.toString()),
          modelText("Freezed", freezedModel.toString()),
          Text(basicModel == basicModel2 ? 'true' : 'false'),
          Text(freezedModel == freezedModel2 ? 'true' : 'false'),
          modelText("Freezed", freezedModel3.toString()),
        ],
      ),
    );
  }
}
