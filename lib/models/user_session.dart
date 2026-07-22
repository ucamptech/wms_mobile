class UserSession {
  const UserSession({
    required this.username,
    required this.name,
    this.role = 'Operator',
  });

  final String username;
  final String name;
  final String role;

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'role': role,
    };
  }

  factory UserSession.fromJson(Map<String, dynamic> json) {
    return UserSession(
      username: json['username'] as String,
      name: json['name'] as String,
      role: (json['role'] as String?) ?? 'Operator',
    );
  }
}
