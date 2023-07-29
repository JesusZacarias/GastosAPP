import 'package:exp_app/pages/add_expenses.dart';
import 'package:exp_app/pages/categories_details.dart';
import 'package:exp_app/pages/expenses_details.dart';
import 'package:exp_app/pages/home_page.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/providers/shared_pref.dart';
import 'package:exp_app/providers/theme_provider.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = UserPrefs();
  await prefs.initPrefs();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UIProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExpensesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(prefs.darkMode),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Material App',
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('es'),
          ],
          initialRoute: 'home',
          theme: value.getTheme(),
          routes: {
            'home': (_) => const HomePage(),
            'add_expenses': (_) => const AddExpenses(),
            'cat_details': (_) => const CategoriesDetails(),
            'exp_details': (_) => const ExpensesDetails(),
          },
        );
      }
    );
  }
  /* Pendientes */
  //Cambiar color del balance cuando sea negativo
}
