import 'package:flutter_dotenv/flutter_dotenv.dart';

class Endpoints {
  static final khokhaWebSocketUrl = dotenv.env['GATELOG-WEBSOCKET-URL']!;
  static final gateLogServerUrl = dotenv.env['GATELOG-SERVER-URL']!;
  static final onestopSecurityKey = dotenv.env['SECURITY-KEY']!;

  static const onestopBaseUrl = String.fromEnvironment('SERVER-URL');
  static const String getAllLogs = '/history';

  static getHeader() {
    return {
      'Content-Type': 'application/json',
      'security-key': Endpoints.onestopSecurityKey,
    };
  }
}
