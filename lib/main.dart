import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quote_of_the_day/theme/dark_theme.dart';
import 'provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),);

}
// change the launcher icon
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Today\'s Quote',
      home: const Home(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      darkTheme: dartTheme,
      debugShowCheckedModeBanner: false,
    );
  }

}