import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

// أنماط النصوص
class AppTextStyles {
  // الخط الأساسي للتطبيق
  static TextStyle get _baseTextStyle => GoogleFonts.cairo(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.normal,
  );
  
  // العناوين الكبيرة
  static TextStyle get headlineLarge => _baseTextStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );
  
  static TextStyle get headlineMedium => _baseTextStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );
  
  static TextStyle get headlineSmall => _baseTextStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  
  // العناوين الفرعية
  static TextStyle get titleLarge => _baseTextStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  static TextStyle get titleMedium => _baseTextStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
  
  static TextStyle get titleSmall => _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );
  
  // النصوص العادية
  static TextStyle get bodyLarge => _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  
  static TextStyle get bodyMedium => _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  
  static TextStyle get bodySmall => _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );
  
  // النصوص المخصصة للتسميات
  static TextStyle get labelLarge => _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
  
  static TextStyle get labelMedium => _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );
  
  static TextStyle get labelSmall => _baseTextStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );
  
  // أنماط خاصة للأزرار
  static TextStyle get buttonLarge => _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    height: 1.2,
  );
  
  static TextStyle get buttonMedium => _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    height: 1.2,
  );
  
  static TextStyle get buttonSmall => _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    height: 1.2,
  );
  
  // أنماط خاصة للحقول
  static TextStyle get fieldLabel => _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
  
  static TextStyle get fieldInput => _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get fieldHint => _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textDisabled,
  );
  
  static TextStyle get fieldError => _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.errorColor,
  );
  
  // أنماط خاصة للحالات
  static TextStyle get successText => _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.successColor,
  );
  
  static TextStyle get errorText => _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.errorColor,
  );
  
  static TextStyle get warningText => _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.warningColor,
  );
  
  static TextStyle get infoText => _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.infoColor,
  );
  
  // أنماط خاصة للروابط
  static TextStyle get linkText => _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryColor,
    decoration: TextDecoration.underline,
  );
  
  // أنماط خاصة للبطاقات
  static TextStyle get cardTitle => _baseTextStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get cardSubtitle => _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  
  // أنماط خاصة للقوائم
  static TextStyle get listTitle => _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get listSubtitle => _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  
  // أنماط خاصة للتبويبات
  static TextStyle get tabSelected => _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor,
  );
  
  static TextStyle get tabUnselected => _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  
  // أنماط خاصة للحالة
  static TextStyle getStatusTextStyle(String status) {
    Color color = AppColors.getStatusColor(status);
    return _baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }
  
  // دالة للحصول على نمط النص مع لون مخصص
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }
  
  // دالة للحصول على نمط النص مع حجم مخصص
  static TextStyle withFontSize(TextStyle style, double fontSize) {
    return style.copyWith(fontSize: fontSize);
  }
  
  // دالة للحصول على نمط النص مع وزن مخصص
  static TextStyle withFontWeight(TextStyle style, FontWeight fontWeight) {
    return style.copyWith(fontWeight: fontWeight);
  }
}
