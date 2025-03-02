// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../env.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// generated_from: .env
final class _Env {
  static const String key = 'thisiskey';

  static const List<int> _enviedkeypassword = <int>[
    869895953,
    4108983230,
    156286770,
    1470146440,
    1877175105,
    1830616956,
    227646441,
    2818231353,
    3050747236,
    2779665819,
    313422407,
    1754444767,
    717208069,
    1344912656,
  ];

  static const List<int> _envieddatapassword = <int>[
    869896037,
    4108983254,
    156286811,
    1470146555,
    1877175080,
    1830616847,
    227646361,
    2818231384,
    3050747159,
    2779665896,
    313422384,
    1754444720,
    717208183,
    1344912756,
  ];

  static final String password = String.fromCharCodes(List<int>.generate(
    _envieddatapassword.length,
    (int i) => i,
    growable: false,
  ).map((int i) => _envieddatapassword[i] ^ _enviedkeypassword[i]));
}
