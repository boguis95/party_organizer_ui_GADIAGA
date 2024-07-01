import 'package:flutter/material.dart';
import 'package:project_party_gadiaga/providers/AuthProvider.dart';
import 'package:project_party_gadiaga/views/HomeScreen.dart';
import 'package:project_party_gadiaga/views/LoginScreen.dart';
import 'package:project_party_gadiaga/views/PartyDetailsScreen.dart';
import 'package:project_party_gadiaga/views/SignupScreen.dart';
import 'package:project_party_gadiaga/views/create_party_screen.dart';
import 'package:project_party_gadiaga/views/edit_party_screen.dart';
import 'package:project_party_gadiaga/views/manage_parties_screen.dart';
import 'package:project_party_gadiaga/views/message_screen.dart';
import 'package:provider/provider.dart';

import 'modeles/Party.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        title: 'Party App',
        theme: ThemeData(
        primarySwatch: Colors.purple,
    colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.purple,
    accentColor: Colors.amber,
    ),
    textTheme: TextTheme(
    headline1: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
    headline6: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
    bodyText2: TextStyle(fontSize: 14.0, color: Colors.white70),
    ),
    appBarTheme: AppBarTheme(
    backgroundColor: Colors.purple,
    ),
    buttonTheme: ButtonThemeData(
    buttonColor: Colors.amber,
    textTheme: ButtonTextTheme.primary,
    )),
        initialRoute: '/login',
        routes: {
          '/': (context) => HomeScreen(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/party-details': (context) => PartyDetailsScreen(),
          '/create-party': (context) => CreatePartyScreen(),
          '/manage-parties': (context) => ManagePartiesScreen(),
        },
          onGenerateRoute: (settings) {
            if (settings.name == '/edit-party') {
              final Party party = settings.arguments as Party;
              return MaterialPageRoute(
                builder: (context) {
                  return EditPartyScreen(party: party);
                },
              );
            } else if (settings.name == '/messaging') {
              final Map<String, int> args = settings.arguments as Map<String, int>;
              return MaterialPageRoute(
                builder: (context) {
                  return MessagingScreen(
                    partyId: args['partyId']!,
                    recipientId: args['recipientId']!,
                  );
                },
              );
            }
            return null;
          },
      ),
    );
  }
}