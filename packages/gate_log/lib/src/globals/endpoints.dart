class Endpoints {
  static const khokhaWebSocketUrl =
      String.fromEnvironment('GATELOG-WEBSOCKET-URL');
  static const gateLogServerUrl = String.fromEnvironment('GATELOG-SERVER-URL');
  static const onestopSecurityKey = String.fromEnvironment('SECURITY-KEY');
  static const onestopBaseUrl = String.fromEnvironment('SERVER-URL');
  static const String getAllLogs = '/history';

  static getHeader() {
    return {
      'Content-Type': 'application/json',
      'security-key': Endpoints.onestopSecurityKey,
    };
  }
}
