class BlessModel {
  num id;
  String name;
  bool done;

  BlessModel({required this.name, required this.done, required this.id});

  // Convert a BlessModel instance to a map
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'done': done,
      };

  // Create a BlessModel instance from a map
  factory BlessModel.fromJson(Map<String, dynamic> json) => BlessModel(
        id: json['id'],
        name: json['name'],
        done: json['done'],
      );
}
