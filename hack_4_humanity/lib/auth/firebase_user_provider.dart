import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Hack4HumanityFirebaseUser {
  Hack4HumanityFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

Hack4HumanityFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Hack4HumanityFirebaseUser> hack4HumanityFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<Hack4HumanityFirebaseUser>(
            (user) => currentUser = Hack4HumanityFirebaseUser(user));
