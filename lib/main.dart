
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'presentation/screens/splash/splash_screen.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/auth/register_screen.dart';
import 'presentation/screens/dashboard/dashboard_screen.dart';
import 'presentation/screens/personal_data/personal_data_form_screen.dart';
import 'presentation/screens/applications/my_applications_screen.dart';

void main() async {
  // تأكد من تهيئة خدمات Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'حقوقي - مؤسسة حقوق الإنسان',
      debugShowCheckedModeBanner: false,
      
      // الثيم مع الخط العربي
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF1976D2),
        useMaterial3: true,
        fontFamily: GoogleFonts.cairo().fontFamily,
      ),
      
      // اللغة والاتجاه
      locale: const Locale('ar', 'IQ'),
      
      // الشاشة الرئيسية
      home: const SplashScreen(),
      
      // المسارات
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/personal-data-form': (context) => const PersonalDataFormScreen(),
        '/my-applications': (context) => const MyApplicationsScreen(),
      },
      
      // إعدادات إضافية
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}
