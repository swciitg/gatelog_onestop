class Endpoints {
  static const khokhaWebSocketUrl =
      String.fromEnvironment('GATELOG_WEBSOCKET_URL');
  static const gateLogServerUrl = String.fromEnvironment('GATELOG_SERVER_URL');
  static const onestopSecurityKey = String.fromEnvironment('SECURITY_KEY');
  static const onestopBaseUrl = String.fromEnvironment('SERVER_URL');

  static const String getAllLogs = '/history';

  static getHeader() {
    return {
      'Content-Type': 'application/json',
      'security-key': Endpoints.onestopSecurityKey,
    };
  }
}
