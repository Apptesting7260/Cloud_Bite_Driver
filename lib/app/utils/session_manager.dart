class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  bool isLoggingOut = false;
  bool isMaintainenceMode = false;
}
