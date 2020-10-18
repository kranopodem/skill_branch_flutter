import '../string_util.dart';

enum LoginType { email, phone }
mixin UserUtils {
   String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();
}
class User {
  String email;
  String phone;

  String _lastName;
  String _firstName;
  LoginType _type;

  List<User> friends = [];

  User._({String firstName, String lastName, String phone, String email})
      : _firstName = firstName,
        _lastName = lastName,
        this.phone = phone,
        this.email = email {
    _type = email != null ? LoginType.email : LoginType.phone;
    print("User was created");
  }

  factory User({String name, String phone, String email}) {
    if (name.isEmpty) throw Exception('User name is empty');

    if ((phone?.isEmpty ?? false))
      throw Exception('Enter don\'t empty phone number');
      
    if ((email?.isEmpty ?? false) )
      throw Exception('Enter don\'t empty email');

    return User._(
      firstName: _getFirstName(name),
      lastName: _getLastName(name),
      phone: phone == null ? null : checkPhone(phone),
      email: email == null ? null : checkEmail(email),
    );
  }

  static String _getLastName(String userName) => userName.split(" ")[1];
  static String _getFirstName(String userName) => userName.split(" ")[0];

  static String checkPhone(String phone) {
    String pattern = r"^(?:[+0])?[0-9]{11}";

    phone = phone.replaceAll(RegExp("[^+\\d]"), "");

    if (phone == null || phone.isEmpty) {
      throw Exception("Enter not empty phone number");
    } else if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception("Enter a valid phone number");
    }

    return phone;
  }

  static String checkEmail(String email) {
    String pattern = r".+@.+";

    if (email == null || email.isEmpty) {
      throw Exception("Enter not empty email address");
    }else if (!RegExp(pattern).hasMatch(email)) {
      print(RegExp(pattern).hasMatch(email));
      throw Exception("Enter a valid email address");
    }

    return email;
  }

  String get login {
    if (_type == LoginType.phone) return phone;

    return email;
  }

  String get name {
    return "${"".capitalize(_firstName)} ${"".capitalize(_lastName)}";
  }

  @override
  bool operator ==(Object object) {
    if (object == null) {
      return false;
    }

    if (object is User) {
      return _firstName == object._firstName &&
          _lastName == object._lastName &&
          (phone == object.phone || email == object.email);
    }
  }

  void addFriend(Iterable<User> newFriend) {
    friends.addAll(newFriend);
  }

  void removeFriend(User user) {
    friends.remove(user);
  }

  String get userInfo => '''
    name: $name
    email: $email
    firstName: $_firstName
    lastname: $_lastName
    friends: ${friends.toList()}
  ''';

  @override
  String toString() {
    return '''
    name: $name
    email: $email
    friends: ${friends.toList()}
  ''';
  }
}
