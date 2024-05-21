import 'package:flutter/material.dart';

import 'pages/login/login.page.dart';
import 'pages/login/register.page.dart';

import 'pages/home.page.dart';

import 'pages/newgroup.page.dart';
import 'pages/group/homegroup.page.dart';
import 'pages/group/configgroup.page.dart';
import 'pages/group/addMember.page.dart';
import 'pages/group/addFiles.page.dart';

import 'pages/group/naipe/managnaipe.page.dart';
import 'pages/group/naipe/usersNaipe.page.dart';
import 'pages/group/naipe/searchUser.page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: false,
          primarySwatch: getMaterialColor(const Color(0xFF191A47)),
          textTheme: Typography(platform: TargetPlatform.iOS).white,
          iconTheme: const IconThemeData(color: Colors.white),
          textButtonTheme: const TextButtonThemeData(
              style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.white))),
          fontFamily: 'Poppins'
          // colorSchemeSeed: Color(0xFF191A47),
          ),
      routes: {
        "/login": (context) => const Login(),
        "/register": (context) => const Register(),
        "/home": (context) => const AuthRouter(),
        "/newgroup": (context) => const NewGroup(),
        "/homegroup": (context) => const HomeGroup(),
        "/configgroup": (context) => const ConfigGroup(),
        "/addmember": (context) => AddMember(),
        "/addfiles": (context) => const AddFiles(),
        "/managnaipe": (context) => const ManagNaipe(),
        "/usersnaipe": (context) => const UsersNaipe(),
        "/searchuser": (context) => const SearchUser(),
      },
      initialRoute: "/home",
    );
  }
}

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}
