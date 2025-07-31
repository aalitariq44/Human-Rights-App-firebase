// الاستثناءات المخصصة للتطبيق
abstract class AppException implements Exception {
  final String message;
  final String? code;
  
  const AppException(this.message, {this.code});
  
  @override
  String toString() => message;
}

// استثناء الشبكة
class NetworkException extends AppException {
  const NetworkException(String message, {String? code}) : super(message, code: code);
}

// استثناء الخادم
class ServerException extends AppException {
  const ServerException(String message, {String? code}) : super(message, code: code);
}

// استثناء المصادقة
class AuthException extends AppException {
  const AuthException(String message, {String? code}) : super(message, code: code);
}

// استثناء التحقق من البيانات
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;
  
  const ValidationException(String message, {String? code, this.fieldErrors}) 
      : super(message, code: code);
}

// استثناء الملفات
class FileException extends AppException {
  const FileException(String message, {String? code}) : super(message, code: code);
}

// استثناء قاعدة البيانات
class DatabaseException extends AppException {
  const DatabaseException(String message, {String? code}) : super(message, code: code);
}

// استثناء التخزين
class StorageException extends AppException {
  const StorageException(String message, {String? code}) : super(message, code: code);
}

// استثناء الصلاحيات
class PermissionException extends AppException {
  const PermissionException(String message, {String? code}) : super(message, code: code);
}

// استثناء انتهاء الجلسة
class SessionExpiredException extends AppException {
  const SessionExpiredException(String message, {String? code}) : super(message, code: code);
}

// استثناء عدم وجود البيانات
class DataNotFoundException extends AppException {
  const DataNotFoundException(String message, {String? code}) : super(message, code: code);
}

// استثناء تجاوز الحد المسموح
class LimitExceededException extends AppException {
  const LimitExceededException(String message, {String? code}) : super(message, code: code);
}

// استثناء الإعدادات
class ConfigurationException extends AppException {
  const ConfigurationException(String message, {String? code}) : super(message, code: code);
}

// فئة مصنع الاستثناءات
class ExceptionFactory {
  // إنشاء استثناء من كود الخطأ
  static AppException fromErrorCode(String code, String message) {
    switch (code) {
      case 'network-error':
      case 'connection-timeout':
      case 'network-request-failed':
        return NetworkException(message, code: code);
        
      case 'server-error':
      case 'internal-server-error':
      case 'service-unavailable':
        return ServerException(message, code: code);
        
      case 'user-not-found':
      case 'wrong-password':
      case 'user-disabled':
      case 'invalid-email':
      case 'email-already-in-use':
      case 'weak-password':
      case 'operation-not-allowed':
      case 'invalid-credential':
        return AuthException(message, code: code);
        
      case 'validation-failed':
      case 'invalid-input':
      case 'required-field-missing':
        return ValidationException(message, code: code);
        
      case 'file-not-found':
      case 'file-too-large':
      case 'invalid-file-type':
      case 'upload-failed':
        return FileException(message, code: code);
        
      case 'database-error':
      case 'query-failed':
      case 'transaction-failed':
        return DatabaseException(message, code: code);
        
      case 'storage-error':
      case 'upload-error':
      case 'download-error':
        return StorageException(message, code: code);
        
      case 'permission-denied':
      case 'insufficient-permissions':
        return PermissionException(message, code: code);
        
      case 'session-expired':
      case 'token-expired':
        return SessionExpiredException(message, code: code);
        
      case 'data-not-found':
      case 'resource-not-found':
        return DataNotFoundException(message, code: code);
        
      case 'limit-exceeded':
      case 'quota-exceeded':
        return LimitExceededException(message, code: code);
        
      case 'configuration-error':
      case 'setup-error':
        return ConfigurationException(message, code: code);
        
      default:
        return ServerException(message, code: code);
    }
  }
  
  // إنشاء استثناء من Firebase Auth
  static AppException fromFirebaseAuthException(dynamic exception) {
    final code = exception.code as String?;
    final message = exception.message as String?;
    
    switch (code) {
      case 'user-not-found':
        return const AuthException('المستخدم غير موجود', code: 'user-not-found');
      case 'wrong-password':
        return const AuthException('كلمة المرور غير صحيحة', code: 'wrong-password');
      case 'user-disabled':
        return const AuthException('تم تعطيل هذا الحساب', code: 'user-disabled');
      case 'invalid-email':
        return const AuthException('عنوان البريد الإلكتروني غير صحيح', code: 'invalid-email');
      case 'email-already-in-use':
        return const AuthException('البريد الإلكتروني مستخدم بالفعل', code: 'email-already-in-use');
      case 'weak-password':
        return const AuthException('كلمة المرور ضعيفة جداً', code: 'weak-password');
      case 'operation-not-allowed':
        return const AuthException('العملية غير مسموحة', code: 'operation-not-allowed');
      case 'too-many-requests':
        return const AuthException('تم تجاوز عدد المحاولات المسموحة. حاول مرة أخرى لاحقاً', code: 'too-many-requests');
      case 'network-request-failed':
        return const NetworkException('خطأ في الاتصال بالشبكة', code: 'network-request-failed');
      default:
        return AuthException(message ?? 'حدث خطأ في المصادقة', code: code);
    }
  }
  
  // إنشاء استثناء من Firebase Firestore
  static AppException fromFirestoreException(dynamic exception) {
    final code = exception.code as String?;
    final message = exception.message as String?;
    
    switch (code) {
      case 'permission-denied':
        return const PermissionException('ليس لديك صلاحية للوصول إلى هذه البيانات', code: 'permission-denied');
      case 'not-found':
        return const DataNotFoundException('البيانات المطلوبة غير موجودة', code: 'not-found');
      case 'already-exists':
        return const DatabaseException('البيانات موجودة بالفعل', code: 'already-exists');
      case 'resource-exhausted':
        return const LimitExceededException('تم تجاوز الحد المسموح من العمليات', code: 'resource-exhausted');
      case 'unauthenticated':
        return const AuthException('يجب تسجيل الدخول أولاً', code: 'unauthenticated');
      case 'unavailable':
        return const ServerException('الخدمة غير متاحة حالياً', code: 'unavailable');
      case 'deadline-exceeded':
        return const NetworkException('انتهت مهلة الاتصال', code: 'deadline-exceeded');
      default:
        return DatabaseException(message ?? 'حدث خطأ في قاعدة البيانات', code: code);
    }
  }
  
  // إنشاء استثناء من Firebase Storage
  static AppException fromStorageException(dynamic exception) {
    final code = exception.code as String?;
    final message = exception.message as String?;
    
    switch (code) {
      case 'object-not-found':
        return const FileException('الملف غير موجود', code: 'object-not-found');
      case 'bucket-not-found':
        return const StorageException('مساحة التخزين غير موجودة', code: 'bucket-not-found');
      case 'project-not-found':
        return const ConfigurationException('المشروع غير موجود', code: 'project-not-found');
      case 'quota-exceeded':
        return const LimitExceededException('تم تجاوز حد التخزين المسموح', code: 'quota-exceeded');
      case 'unauthenticated':
        return const AuthException('يجب تسجيل الدخول أولاً', code: 'unauthenticated');
      case 'unauthorized':
        return const PermissionException('ليس لديك صلاحية لرفع الملفات', code: 'unauthorized');
      case 'retry-limit-exceeded':
        return const NetworkException('فشل في رفع الملف بعد عدة محاولات', code: 'retry-limit-exceeded');
      case 'invalid-checksum':
        return const FileException('الملف تالف أو معطوب', code: 'invalid-checksum');
      case 'canceled':
        return const FileException('تم إلغاء رفع الملف', code: 'canceled');
      default:
        return StorageException(message ?? 'حدث خطأ في التخزين', code: code);
    }
  }
}
