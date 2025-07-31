// ثوابت التخزين المحلي والملفات
class StorageConstants {
  // مفاتيح التخزين المحلي
  static const String keyUserToken = 'user_token';
  static const String keyUserEmail = 'user_email';
  static const String keyUserUid = 'user_uid';
  static const String keyLastLoginDate = 'last_login_date';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguageCode = 'language_code';
  static const String keyApplicationDraft = 'application_draft';
  static const String keyTutorialCompleted = 'tutorial_completed';
  
  // مسارات الملفات المؤقتة
  static const String tempDirectory = 'temp';
  static const String documentsDirectory = 'documents';
  static const String imagesDirectory = 'images';
  static const String cacheDirectory = 'cache';
  
  // أسماء قواعد البيانات المحلية
  static const String localDbName = 'hoqoqi_local.db';
  static const String localDbVersion = '1.0';
  
  // أسماء الجداول المحلية
  static const String draftsTable = 'drafts';
  static const String cacheTable = 'cache';
  static const String logsTable = 'logs';
  
  // مفاتيح التفضيلات
  static const String prefNotificationsEnabled = 'notifications_enabled';
  static const String prefAutoSaveDrafts = 'auto_save_drafts';
  static const String prefBiometricAuth = 'biometric_auth';
  static const String prefDataCompression = 'data_compression';
  
  // مدة انتهاء صلاحية التخزين المؤقت
  static const Duration cacheExpiration = Duration(hours: 24);
  static const Duration draftExpiration = Duration(days: 30);
  static const Duration logExpiration = Duration(days: 7);
  
  // حد أقصى لحجم التخزين المؤقت
  static const int maxCacheSizeMB = 100;
  static const int maxDraftsSizeMB = 50;
  static const int maxLogsSizeMB = 10;
  
  // أنواع الملفات وامتداداتها
  static const Map<String, List<String>> fileExtensions = {
    'image': ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'],
    'document': ['pdf', 'doc', 'docx', 'txt'],
    'archive': ['zip', 'rar', '7z'],
  };
  
  // أحجام ضغط الصور
  static const int thumbnailSize = 150;
  static const int previewSize = 500;
  static const int fullImageSize = 1920;
  
  // جودة ضغط الصور (0-100)
  static const int imageQualityHigh = 85;
  static const int imageQualityMedium = 70;
  static const int imageQualityLow = 50;
}
