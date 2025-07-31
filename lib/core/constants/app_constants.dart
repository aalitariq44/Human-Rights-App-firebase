// ثوابت التطبيق العامة
class AppConstants {
  // معلومات التطبيق
  static const String appName = 'حقوقي';
  static const String appVersion = '1.0.0';
  static const String organizationName = 'مؤسسة حقوق الإنسان';
  
  // أحجام الشاشة
  static const double maxWidth = 600.0;
  static const double padding = 16.0;
  static const double margin = 8.0;
  static const double borderRadius = 12.0;
  
  // أحجام النص
  static const double textSizeSmall = 12.0;
  static const double textSizeMedium = 16.0;
  static const double textSizeLarge = 20.0;
  static const double textSizeXLarge = 24.0;
  
  // مدة الرسوم المتحركة
  static const Duration animationDuration = Duration(milliseconds: 300);
  
  // حد أقصى لحجم الملفات
  static const int maxImageSizeMB = 5;
  static const int maxPdfSizeMB = 10;
  
  // تنسيقات الملفات المسموحة
  static const List<String> allowedImageFormats = ['jpg', 'jpeg', 'png'];
  static const List<String> allowedDocumentFormats = ['pdf'];
  
  // مدة انتهاء الجلسة
  static const Duration sessionTimeout = Duration(minutes: 30);
  
  // تنسيق التاريخ
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  
  // رسائل الخطأ
  static const String networkError = 'خطأ في الاتصال بالشبكة';
  static const String serverError = 'خطأ في الخادم';
  static const String unknownError = 'حدث خطأ غير متوقع';
  
  // رسائل النجاح
  static const String dataSubmittedSuccess = 'تم إرسال البيانات بنجاح';
  static const String fileUploadedSuccess = 'تم رفع الملف بنجاح';
  
  // أرقام الخطوات في النموذج
  static const int totalSteps = 6;
  static const int personalDataStep = 0;
  static const int nationalIdStep = 1;
  static const int kuwaitDataStep = 2;
  static const int compensationStep = 3;
  static const int documentsStep = 4;
  static const int reviewStep = 5;
}
