import 'package:flutter/material.dart';

class AuthenticatedScope<T> extends InheritedWidget {
  final T currentUser;
  final Function onLogout;
  const AuthenticatedScope(this.onLogout,
      {required this.currentUser, required super.child, Key? key})
      : super(key: key);

  static AuthenticatedScope<T> of<T>(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<AuthenticatedScope<T>>();
    if (widget == null) {
      throw Exception("Cant Found AuthenticatedWidget in the tree");
    }
    return widget;
  }

  @override
  bool updateShouldNotify(AuthenticatedScope<T> oldWidget) {
    return oldWidget.currentUser != currentUser;
  }
}

extension AuthCtxExt on BuildContext {
  AuthenticatedScope<T> auth<T>() => AuthenticatedScope.of(this);

  T currentUser<T>() => auth<T>().currentUser;

  void logOut<T>() => auth<T>().onLogout();
}
