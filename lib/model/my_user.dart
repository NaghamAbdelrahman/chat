class MyUser {
  static const String collectionName = 'users';
  String? id;
  String? fullName;
  String? email;

  MyUser({this.id, this.fullName, this.email});

  MyUser.fromFireStore(Map<String, dynamic> data)
      : this(id: data['id'], fullName: data['fullName'], email: data['email']);

  Map<String, dynamic> toFireStore() {
    return {'id': id, 'fullName': fullName, 'email': email};
  }
}
