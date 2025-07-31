import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'text_styles.dart';

// ثيم التطبيق
class AppTheme {
  // الحصول على الثيم الفاتح
  static ThemeData get lightTheme {
    return ThemeData(
      // الألوان الأساسية
      primarySwatch: Colors.blue,
      primaryColor: AppColors.primaryColor,
      primaryColorDark: AppColors.primaryDarkColor,
      primaryColorLight: AppColors.primaryLightColor,
      
      // لوحة الألوان
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor,
        primaryContainer: AppColors.primaryLightColor,
        secondary: AppColors.secondaryColor,
        secondaryContainer: AppColors.secondaryColor,
        surface: AppColors.surfaceColor,
        background: AppColors.backgroundColor,
        error: AppColors.errorColor,
        onPrimary: AppColors.textOnPrimary,
        onSecondary: AppColors.textOnSecondary,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
        onError: AppColors.textOnPrimary,
        brightness: Brightness.light,
      ),
      
      // الخلفية والسطح
      scaffoldBackgroundColor: AppColors.backgroundColor,
      canvasColor: AppColors.surfaceColor,
      cardColor: AppColors.cardColor,
      dialogBackgroundColor: AppColors.dialogColor,
      
      // شريط التطبيق
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 2,
        shadowColor: AppColors.shadowColor,
        centerTitle: true,
        titleTextStyle: AppTextStyles.titleLarge.copyWith(
          color: AppColors.textOnPrimary,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.surfaceColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      
      // الأزرار المرتفعة
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 2,
          shadowColor: AppColors.shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: AppTextStyles.buttonMedium,
        ),
      ),
      
      // الأزرار المحددة
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          side: const BorderSide(color: AppColors.primaryColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: AppTextStyles.buttonMedium.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      
      // الأزرار النصية
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: AppTextStyles.buttonMedium.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      
      // حقول الإدخال
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorColor, width: 2),
        ),
        labelStyle: AppTextStyles.fieldLabel,
        hintStyle: AppTextStyles.fieldHint,
        errorStyle: AppTextStyles.fieldError,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      
      // البطاقات
      cardTheme: CardThemeData(
        color: AppColors.cardColor,
        elevation: 2,
        shadowColor: AppColors.shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(8),
      ),
      
      // الحوارات
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.dialogColor,
        elevation: 8,
        shadowColor: AppColors.shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: AppTextStyles.titleMedium,
        contentTextStyle: AppTextStyles.bodyMedium,
      ),
      
      // شريط القوائم السفلي
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceColor,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.textSecondary,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      
      // التبويبات
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primaryColor,
        unselectedLabelColor: AppColors.textSecondary,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        labelStyle: AppTextStyles.tabSelected,
        unselectedLabelStyle: AppTextStyles.tabUnselected,
      ),
      
      // شريط التقدم
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryColor,
        linearTrackColor: AppColors.borderColor,
        circularTrackColor: AppColors.borderColor,
      ),
      
      // المفاتيح
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primaryColor;
          }
          return AppColors.textDisabled;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primaryLightColor;
          }
          return AppColors.borderColor;
        }),
      ),
      
      // صناديق التحديد
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primaryColor;
          }
          return Colors.transparent;
        }),
        checkColor: MaterialStateProperty.all(AppColors.textOnPrimary),
        side: const BorderSide(color: AppColors.borderColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      
      // أزرار الراديو
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primaryColor;
          }
          return AppColors.textDisabled;
        }),
      ),
      
      // الفواصل
      dividerColor: AppColors.dividerColor,
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerColor,
        thickness: 1,
        space: 1,
      ),
      
      // أنماط النصوص
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        headlineSmall: AppTextStyles.headlineSmall,
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        titleSmall: AppTextStyles.titleSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ),
      
      // الاتجاه للنصوص العربية
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
  
  // الحصول على الثيم الداكن
  static ThemeData get darkTheme {
    return lightTheme.copyWith(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkPrimaryColor,
        primaryContainer: AppColors.darkPrimaryColor,
        secondary: AppColors.secondaryColor,
        secondaryContainer: AppColors.secondaryColor,
        surface: AppColors.darkSurfaceColor,
        background: AppColors.darkBackgroundColor,
        error: AppColors.errorColor,
        onPrimary: AppColors.textOnPrimary,
        onSecondary: AppColors.textOnSecondary,
        onSurface: AppColors.darkTextPrimary,
        onBackground: AppColors.darkTextPrimary,
        onError: AppColors.textOnPrimary,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      canvasColor: AppColors.darkSurfaceColor,
      cardColor: AppColors.darkCardColor,
      dialogBackgroundColor: AppColors.darkSurfaceColor,
      appBarTheme: lightTheme.appBarTheme.copyWith(
        backgroundColor: AppColors.darkSurfaceColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.darkBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
    );
  }
}
