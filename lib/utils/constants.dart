import 'package:flutter_boilerplate/data/local/env_key.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Flavor { dev, stag, prod }

class Constants {
  const Constants({required this.baseUrl, required this.secretKey});

  factory Constants.shared() {
    if (_instance != null) {
      return _instance!;
    }
    return Constants(
      baseUrl: EnvKey.baseUrl.read(),
      secretKey: EnvKey.secretKey.read(),
    );
  }

  final String baseUrl;
  final String secretKey;

  static Constants? _instance;
}

Future<void> loadEnvironmentOfFlavor() async {
  final flavor = EnumToString.fromString(
      Flavor.values, const String.fromEnvironment('FLAVOR'));
  switch (flavor) {
    case Flavor.prod:
      await dotenv.load(fileName: ".env_prod");
      break;
    case Flavor.stag:
      await dotenv.load(fileName: ".env_stag");
      break;
    case Flavor.dev:
      await dotenv.load(fileName: ".env_dev");
    default:
      break;
  }
}
