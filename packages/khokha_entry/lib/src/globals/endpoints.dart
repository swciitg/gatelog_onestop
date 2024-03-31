class Endpoints {
  static const webSocketUrl = String.fromEnvironment('KHOKHA-WEBSOCKET-URL');
  static const onestopSecurityKey =
      String.fromEnvironment('ONESTOP-SECURITY-KEY');

  static getHeader() {
    return {
      'Content-Type': 'application/json',
      'security-key': Endpoints.onestopSecurityKey,
    };
  }
}
