class User {
  final String id;
  final String name;
  final String email;

  User({
    this.id,
    this.name,
    this.email,
  });

  User copyWith({String name, String photoURL}) => User(
    id: this.id,
    name: name ?? this.name,
    email: this.email,
  );
}