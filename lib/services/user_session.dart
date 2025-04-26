class UserSession {
  static final UserSession _instance = UserSession._internal();

  factory UserSession() {
    return _instance;
  }

  UserSession._internal();

  String? userId;
  String? role;

  void clear() {
    userId = null;
    role = null;
  }
}
