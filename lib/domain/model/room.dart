class Room {
  static const String collectionName = 'room';
  String? id;
  String? name;
  String? description;
  String? catId;

  Room({this.id, this.name, this.description, this.catId});

  Room.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            name: data['name'],
            description: data['description'],
            catId: data['catId']);

  Map<String, dynamic> toFireStore() {
    return {'id': id, 'name': name, 'description': description, 'catId': catId};
  }
}
