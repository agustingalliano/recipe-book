class User {

  final int id;
  final String username;
  final String password;

  User(this.id, this.username, this.password);

  factory User.fromJson(dynamic json) {
    return User(
        json['id'] as int,
        json['username'] as String,
        json['password'] as String,
    );
  }

  static List<User> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return User.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Recipe{id: $id, username: $username, password: $password}';
  }
}