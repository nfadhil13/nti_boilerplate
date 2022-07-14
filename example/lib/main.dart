import 'package:example/preference/color_themes.dart';
import 'package:flutter/material.dart';
import 'package:nti_boilerplate/auth/authenticated_scope.dart';
import 'package:nti_boilerplate/preferences/color_theme.dart';

class User {
  final String name;
  final String token;

  User(this.name, this.token);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ColorThemeWidget(
        initialTheme: DarkMode(),
        child: AuthenticatedScope<User>(() {
          //Do something to logut
          print("Logout");
        },
            currentUser: User("John Doe", "This is the token"),
            child: const MyHomePage()),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme().primary(),
      body: Column(
        children: [
          Text(
            context.currentUser<User>().name,
            style: TextStyle(color: context.colorTheme().onPrimary()),
          ),
          Text(context.currentUser<User>().token,
              style: TextStyle(color: context.colorTheme().onPrimary())),
          ElevatedButton(
              onPressed: () {
                context.logOut<User>();
              },
              child: const Text("Logout")),
          ElevatedButton(
              onPressed: () {
                final currentColorTheme = context.colorTheme();
                context.colorScope().changeCurrentColor(
                    currentColorTheme is DarkMode ? WhiteMode() : DarkMode());
              },
              child: const Text("Change Theme"))
        ],
      ),
    );
  }
}
