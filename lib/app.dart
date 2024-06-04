import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
import 'pages/group/naipe/addNaipe.page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
      routerConfig: GoRouter(
        initialLocation: '/home',
        routes: [
          GoRoute(
            path: '/login',
            builder: (context, state) => const Login(),
          ),
          GoRoute(
            path: '/register',
            builder: (context, state) => const Register(),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const AuthRouter(),
          ),
          GoRoute(
            path: '/newgroup',
            builder: (context, state) => const NewGroup(),
          ),
          GoRoute(
            path: '/homegroup',
            builder: (context, state) => const HomeGroup(),
          ),
          GoRoute(
            path: '/configgroup',
            builder: (context, state) => const ConfigGroup(),
          ),
          GoRoute(
            path: '/addmember',
            builder: (context, state) => AddMember(),
          ),
          GoRoute(
            path: '/addfiles',
            builder: (context, state) => const AddFiles(),
          ),
          GoRoute(
            path: '/managnaipe/:id',
            builder: (context, state) => ManagNaipe(state.pathParameters['id']!),
          ),
          GoRoute(
            path: '/usersnaipe',
            builder: (context, state) => const UsersNaipe(),
          ),
          GoRoute(
            path: '/searchuser',
            builder: (context, state) => const SearchUser(),
          ),
          GoRoute(
            path: '/addnaipe/:id',
            builder: (context, state) => AddNaipe(state.pathParameters['id']!),
          ),
        ]
      ),
    );
  }
}

        // "/register": (context) => Register(),
        // "/home": (context) => AuthRouter(),
        // "/newgroup": (context) => NewGroup(),
        // "/homegroup": (context) => HomeGroup(),
        // "/configgroup": (context) => ConfigGroup(),
        // "/addmember": (context) => AddMember(),
        // "/addfiles": (context) => AddFiles(),
        // "/managnaipe": (context) => ManagNaipe(),
        // "/usersnaipe": (context) => UsersNaipe(),
        // "/searchuser": (context) => SearchUser(),
        // "/addnaipe": (context) => AddNaipe(),

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
