class Endpoints {
  static const khokhaWebSocketUrl = String.fromEnvironment('KHOKHA-WEBSOCKET-URL');
  static const onestopSecurityKey = String.fromEnvironment('SECURITY-KEY');

  static getHeader() {
    return {
      'Content-Type': 'application/json',
      'security-key': Endpoints.onestopSecurityKey,
    };
  }
}
