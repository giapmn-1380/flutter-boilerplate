import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvKey {
  baseUrl("BASE_URL"),
  secretKey("SECRET_KEY");

  final String key;

  const EnvKey(this.key);
}

extension EnvKeyEx on EnvKey {
  String read() {
    return dotenv.get(key, fallback: "");
  }
}
