import 'models/user.dart';

class UserHolder {
  Map<String, User> users = {};
  List<User> listUsers = [];

  // init() {
  //   User user = User(name: "", email: "", phone: "");
  // }

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    if (!users.containsKey(user.login)) {
      users.addAll({user.login: user});
    } else {
      throw Exception('A user with this name already exists.');
    }

  }

  User getUserByLogin(String login) {
    if (users.containsKey(login)) {
      return users[login];
    } else {
      throw Exception('A user is not exists.');
    }
  }

  User registerUserByEmail(String fullName, String email) {
    User user = User(name: fullName, email: email);

    if (!users.containsKey(user.login)) {
      users.addAll({user.login: user});
    } else {
      throw Exception('A user with this email already exists.');
    }


    return user;
  }

  User registerUserByPhone(String fullName, String phone) {
    User user = User(name: fullName, phone: phone);

    if (!users.containsKey(user.login)) {
      users.addAll({user.login: user});
    } else {
      throw Exception('A user with this phone already exists.');
    }


    return user;
  }

  void setFriends(String login, List<User> friends) {
    User user = getUserByLogin(login);
    user.friends = friends;
  }

  User findUserInFriends(String fullName, User user) {
    if (users.containsKey(fullName)) {
      if (users[fullName].friends.contains(user)) {
        return user;
      } else {
        throw Exception("${user.login} is not a friend of the login");
      }
    } else {
      throw Exception("A user is not exists.");
    }
  }

  List<User> importUsers(List<String> user) {
    user.forEach((item) {
      List<String> newUser = item.split(';');
      registerUser(newUser[0].trim(), newUser[2].trim(), newUser[1].trim());
    });
    // print(users);
    users.forEach((key, value) {
      print(value);
      listUsers.add(value);
    });
print(listUsers);
    return listUsers;
  }
}
