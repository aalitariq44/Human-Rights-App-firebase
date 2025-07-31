import 'package:flutter/material.dart';

// ألوان التطبيق
class AppColors {
  // الألوان الأساسية
  static const Color primaryColor = Color(0xFF1976D2);      // أزرق احترافي
  static const Color primaryDarkColor = Color(0xFF1565C0);  // أزرق داكن
  static const Color primaryLightColor = Color(0xFFBBDEFB); // أزرق فاتح
  
  // الألوان الثانوية
  static const Color secondaryColor = Color(0xFF388E3C);     // أخضر للنجاح
  static const Color errorColor = Color(0xFFD32F2F);         // أحمر للأخطاء
  static const Color warningColor = Color(0xFFF57C00);       // برتقالي للتحذيرات
  static const Color infoColor = Color(0xFF0288D1);          // أزرق للمعلومات
  
  // ألوان الخلفية
  static const Color backgroundColor = Color(0xFFFAFAFA);    // رمادي فاتح جداً
  static const Color surfaceColor = Color(0xFFFFFFFF);       // أبيض
  static const Color cardColor = Color(0xFFF5F5F5);          // رمادي فاتح للبطاقات
  static const Color dialogColor = Color(0xFFFFFFFF);        // أبيض للحوارات
  
  // ألوان النص
  static const Color textPrimary = Color(0xFF212121);        // نص أساسي داكن
  static const Color textSecondary = Color(0xFF757575);      // نص ثانوي رمادي
  static const Color textDisabled = Color(0xFFBDBDBD);       // نص معطل
  static const Color textOnPrimary = Color(0xFFFFFFFF);      // نص على الألوان الأساسية
  static const Color textOnSecondary = Color(0xFFFFFFFF);    // نص على الألوان الثانوية
  
  // ألوان الحدود والفواصل
  static const Color borderColor = Color(0xFFE0E0E0);        // حدود رمادية فاتحة
  static const Color dividerColor = Color(0xFFEEEEEE);       // فواصل رمادية
  static const Color shadowColor = Color(0x1F000000);        // ظلال شفافة
  
  // ألوان الحالة
  static const Color successColor = Color(0xFF4CAF50);       // أخضر للنجاح
  static const Color pendingColor = Color(0xFFFF9800);       // برتقالي للانتظار
  static const Color rejectedColor = Color(0xFFF44336);      // أحمر للرفض
  static const Color draftColor = Color(0xFF9E9E9E);         // رمادي للمسودات
  
  // ألوان التدرج
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, primaryDarkColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF388E3C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient warningGradient = LinearGradient(
    colors: [Color(0xFFFF9800), Color(0xFFF57C00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // ألوان الشاشة الداكنة
  static const Color darkPrimaryColor = Color(0xFF1E88E5);
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkSurfaceColor = Color(0xFF1E1E1E);
  static const Color darkCardColor = Color(0xFF2C2C2C);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  
  // ألوان للحالات التفاعلية
  static const Color hoverColor = Color(0x0F000000);         // تأثير التمرير
  static const Color focusColor = Color(0x1F000000);         // تأثير التركيز
  static const Color splashColor = Color(0x1F000000);        // تأثير اللمس
  static const Color highlightColor = Color(0x1F000000);     // تأثير التحديد
  
  // ألوان خاصة بالتطبيق
  static const Color stepperActiveColor = primaryColor;
  static const Color stepperInactiveColor = Color(0xFFE0E0E0);
  static const Color stepperCompletedColor = successColor;
  
  static const Color uploadProgressColor = primaryColor;
  static const Color uploadCompleteColor = successColor;
  static const Color uploadErrorColor = errorColor;
  
  // دالة للحصول على لون حسب حالة الطلب
  static Color getStatusColor(String status) {
    switch (status) {
      case 'under_review':
        return pendingColor;
      case 'approved':
        return successColor;
      case 'rejected':
        return rejectedColor;
      case 'needs_more_info':
        return warningColor;
      default:
        return draftColor;
    }
  }
  
  // دالة للحصول على لون مع الشفافية
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
}
