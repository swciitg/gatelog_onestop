class Endpoints{
  static const apiSecurityKey = const String.fromEnvironment('SECURITY-KEY');
  static const websocketURL = "wss://swc.iitg.ac.in/test/khokhaEntry/api/ws";

  static getHeader() {
    return {'Content-Type': 'application/json', 'security-key': Endpoints.apiSecurityKey};
  }
}