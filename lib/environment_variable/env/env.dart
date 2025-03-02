import 'package:envied/envied.dart';

part 'generated/env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'KEY')
  static String key = _Env.key;

  @EnviedField(varName: 'PASSWORD', obfuscate: true)
  static String password = _Env.password;
}
