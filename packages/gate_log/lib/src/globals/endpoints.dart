import 'package:flutter_dotenv/flutter_dotenv.dart';

class Endpoints {
  static final khokhaWebSocketUrl = dotenv.env['GATELOG_WEBSOCKET_URL']!;
  static final gateLogServerUrl = dotenv.env['GATELOG_SERVER_URL']!;
  static final onestopSecurityKey = dotenv.env['SECURITY_KEY']!;
  static final onestopBaseUrl = dotenv.env['SERVER_URL']!;
  
  static const String getAllLogs = '/history';

  static getHeader() {
    return {
      'Content-Type': 'application/json',
      'security-key': Endpoints.onestopSecurityKey,
    };
  }
}
