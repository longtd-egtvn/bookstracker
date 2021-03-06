import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class BookstrackerFirebaseUser {
  BookstrackerFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

BookstrackerFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<BookstrackerFirebaseUser> bookstrackerFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<BookstrackerFirebaseUser>(
            (user) => currentUser = BookstrackerFirebaseUser(user));
