class Location {
  String name;
  String? parentId;
  List<Location> children = [];
  String id;
  Location({
    required this.name,
    this.parentId,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'parentId': parentId,
      'id': id,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      name: map['name'],
      parentId: map['parentId'],
      id: map['id'],
    );
  }
}
