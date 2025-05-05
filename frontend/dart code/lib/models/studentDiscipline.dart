class StudentDicipline {
  String _disciplineName;
  int _id;
  String _name;
  String _email;
  String _registration;

  StudentDicipline({
    required int id,
    required String name,
    required String disciplineName,
    required String email,
    required String registration,
  })  : _disciplineName = disciplineName, _id = id,
        _name = name,
        _email = email,
        _registration = registration;

  // Getters
  int get id => _id;
  String get name => _name;
   String get discipline => _disciplineName;
  String get email => _email;
  String get registration => _registration;

  // Setters
  set id(int value) {
    _id = value;
  }
   // Setters
  set discipline(String value) {
    _disciplineName = value;
  }


  set name(String value) {
    _name = value;
  }

  set email(String value) {
    _email = value;
  }

  set registration(String value) {
    _registration = value;
  }

  @override
  String toString() {
    return 'Student discipline{'
        'id: $_id, '
        'name: $_name, '
        'email: $_email, '
        'registration: $_registration'
        '}';
  }
}
