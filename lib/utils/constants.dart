import 'package:flutter_boilerplate/data/local/env_key.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Flavor { dev, stag, prod }

/// [Flavor]を取得します。
Flavor get env {
  const flavorValue = String.fromEnvironment('FLAVOR');
  if (flavorValue == Flavor.dev.name) {
    return Flavor.dev;
  } else if (flavorValue == Flavor.stag.name) {
    return Flavor.stag;
  } else if (flavorValue == Flavor.prod.name) {
    return Flavor.prod;
  }
  return Flavor.dev;
}

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
  await dotenv.load(fileName: ".env_${env.name}");
}

bool get isTestMode {
  return env != Flavor.prod;
}
