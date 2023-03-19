class RoomCategory {
  String id;
  String name;

  RoomCategory({required this.id, required this.name});

  static List<RoomCategory> getRoomCategories() {
    return [
      RoomCategory(id: 'music', name: 'Music'),
      RoomCategory(id: 'movies', name: 'Movies'),
      RoomCategory(id: 'sports', name: 'Sports'),
    ];
  }
}
