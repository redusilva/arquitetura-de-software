class Subject {
  int _id;
  String _name;

  Subject({
    required int id,
    required String name,
  })  : _id = id,
        _name = name;

  // Getters
  int get id => _id;
  String get name => _name;

  // Setters
  set id(int value) {
    _id = value;
  }

  set name(String value) {
    _name = value;
  }

  @override
  String toString() {
    return 'Subject{'
        'id: $_id, '
        'name: $_name'
        '}';
  }
}
