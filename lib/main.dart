import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_page.dart';
import 'screens/dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  final role = prefs.getString('role') ?? ''; // Add this line

  runApp(MyApp(
    initialIsLoggedIn: isLoggedIn,
    initialIsDarkMode: isDarkMode,
    initialRole: role,
  ));
}

class MyApp extends StatefulWidget {
  final bool initialIsLoggedIn;
  final bool initialIsDarkMode;
  final String initialRole; // Add this line

  const MyApp({
    super.key,
    required this.initialIsLoggedIn,
    required this.initialIsDarkMode,
    required this.initialRole, // Add this line
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isLoggedIn;
  late bool _isDarkMode;
  late String _role; // Add this line

  @override
  void initState() {
    super.initState();
    _isLoggedIn = widget.initialIsLoggedIn;
    _isDarkMode = widget.initialIsDarkMode;
    _role = widget.initialRole;
  }

  Future<void> _toggleDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData lightTheme = ThemeData.light().copyWith(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF3282B8),
        secondary: Color(0xFFBBE1FA),
        surface: Colors.white,
        background: Color(0xFFF0F4F8),
        onPrimary: Colors.white,
        onSecondary: Colors.black87,
        onSurface: Colors.black87,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0F4C75),
        foregroundColor: Colors.white,
        elevation: 4,
      ),
    );

    final ThemeData darkTheme = ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF66FCF1),
        secondary: Color(0xFF45A29E),
        surface: Color(0xFF1F2833),
        background: Color(0xFF121212),
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1F2833),
        foregroundColor: Colors.white,
        elevation: 4,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Library App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: _isLoggedIn
          ? DashboardPage(
              isDarkMode: _isDarkMode,
              onToggleDarkMode: _toggleDarkMode,
              role: _role,
            )
          : LoginPage(
              onLoginSuccess: () async {
                final prefs = await SharedPreferences.getInstance();
                setState(() {
                  _isLoggedIn = true;
                  _role = prefs.getString('role') ?? '';
                });
              },
            ),
    );
  }
}
