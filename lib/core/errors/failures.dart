import 'exceptions.dart';

// أنواع الفشل
abstract class Failure {
  final String message;
  final String? code;
  
  const Failure(this.message, {this.code});
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          code == other.code;
  
  @override
  int get hashCode => message.hashCode ^ code.hashCode;
  
  @override
  String toString() => message;
}

// فشل الشبكة
class NetworkFailure extends Failure {
  const NetworkFailure(String message, {String? code}) : super(message, code: code);
}

// فشل الخادم
class ServerFailure extends Failure {
  const ServerFailure(String message, {String? code}) : super(message, code: code);
}

// فشل المصادقة
class AuthFailure extends Failure {
  const AuthFailure(String message, {String? code}) : super(message, code: code);
}

// فشل التحقق من البيانات
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;
  
  const ValidationFailure(String message, {String? code, this.fieldErrors}) 
      : super(message, code: code);
}

// فشل الملفات
class FileFailure extends Failure {
  const FileFailure(String message, {String? code}) : super(message, code: code);
}

// فشل قاعدة البيانات
class DatabaseFailure extends Failure {
  const DatabaseFailure(String message, {String? code}) : super(message, code: code);
}

// فشل التخزين
class StorageFailure extends Failure {
  const StorageFailure(String message, {String? code}) : super(message, code: code);
}

// فشل الصلاحيات
class PermissionFailure extends Failure {
  const PermissionFailure(String message, {String? code}) : super(message, code: code);
}

// فشل انتهاء الجلسة
class SessionExpiredFailure extends Failure {
  const SessionExpiredFailure(String message, {String? code}) : super(message, code: code);
}

// فشل عدم وجود البيانات
class DataNotFoundFailure extends Failure {
  const DataNotFoundFailure(String message, {String? code}) : super(message, code: code);
}

// فشل تجاوز الحد المسموح
class LimitExceededFailure extends Failure {
  const LimitExceededFailure(String message, {String? code}) : super(message, code: code);
}

// فشل الإعدادات
class ConfigurationFailure extends Failure {
  const ConfigurationFailure(String message, {String? code}) : super(message, code: code);
}

// فشل عام
class GeneralFailure extends Failure {
  const GeneralFailure(String message, {String? code}) : super(message, code: code);
}

// فئة مصنع الفشل
class FailureFactory {
  // تحويل الاستثناء إلى فشل
  static Failure fromException(AppException exception) {
    switch (exception.runtimeType) {
      case NetworkException:
        return NetworkFailure(exception.message, code: exception.code);
      case ServerException:
        return ServerFailure(exception.message, code: exception.code);
      case AuthException:
        return AuthFailure(exception.message, code: exception.code);
      case ValidationException:
        final validationException = exception as ValidationException;
        return ValidationFailure(
          exception.message, 
          code: exception.code,
          fieldErrors: validationException.fieldErrors,
        );
      case FileException:
        return FileFailure(exception.message, code: exception.code);
      case DatabaseException:
        return DatabaseFailure(exception.message, code: exception.code);
      case StorageException:
        return StorageFailure(exception.message, code: exception.code);
      case PermissionException:
        return PermissionFailure(exception.message, code: exception.code);
      case SessionExpiredException:
        return SessionExpiredFailure(exception.message, code: exception.code);
      case DataNotFoundException:
        return DataNotFoundFailure(exception.message, code: exception.code);
      case LimitExceededException:
        return LimitExceededFailure(exception.message, code: exception.code);
      case ConfigurationException:
        return ConfigurationFailure(exception.message, code: exception.code);
      default:
        return GeneralFailure(exception.message, code: exception.code);
    }
  }
  
  // تحويل الخطأ العام إلى فشل
  static Failure fromError(dynamic error) {
    if (error is AppException) {
      return fromException(error);
    }
    
    return GeneralFailure(error.toString());
  }
  
  // الحصول على رسالة صديقة للمستخدم
  static String getUserFriendlyMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return 'تحقق من اتصالك بالإنترنت وحاول مرة أخرى';
      case ServerFailure:
        return 'خطأ في الخادم. حاول مرة أخرى لاحقاً';
      case AuthFailure:
        return 'خطأ في تسجيل الدخول. تحقق من بياناتك';
      case ValidationFailure:
        return 'يرجى التحقق من البيانات المدخلة';
      case FileFailure:
        return 'خطأ في الملف. تحقق من نوع وحجم الملف';
      case DatabaseFailure:
        return 'خطأ في حفظ البيانات. حاول مرة أخرى';
      case StorageFailure:
        return 'خطأ في رفع الملف. حاول مرة أخرى';
      case PermissionFailure:
        return 'ليس لديك صلاحية لتنفيذ هذا الإجراء';
      case SessionExpiredFailure:
        return 'انتهت صلاحية الجلسة. يرجى تسجيل الدخول مرة أخرى';
      case DataNotFoundFailure:
        return 'البيانات المطلوبة غير موجودة';
      case LimitExceededFailure:
        return 'تم تجاوز الحد المسموح. حاول مرة أخرى لاحقاً';
      case ConfigurationFailure:
        return 'خطأ في إعدادات التطبيق';
      default:
        return failure.message.isNotEmpty ? failure.message : 'حدث خطأ غير متوقع';
    }
  }
  
  // التحقق من إمكانية إعادة المحاولة
  static bool isRetryable(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
      case ServerFailure:
      case DatabaseFailure:
      case StorageFailure:
        return true;
      case AuthFailure:
      case ValidationFailure:
      case PermissionFailure:
      case DataNotFoundFailure:
      case ConfigurationFailure:
        return false;
      case SessionExpiredFailure:
      case LimitExceededFailure:
        return true; // بعد فترة
      default:
        return false;
    }
  }
  
  // الحصول على أيقونة الخطأ
  static String getErrorIcon(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return '🌐';
      case ServerFailure:
        return '⚠️';
      case AuthFailure:
        return '🔐';
      case ValidationFailure:
        return '❌';
      case FileFailure:
        return '📁';
      case DatabaseFailure:
        return '💾';
      case StorageFailure:
        return '☁️';
      case PermissionFailure:
        return '🚫';
      case SessionExpiredFailure:
        return '⏰';
      case DataNotFoundFailure:
        return '🔍';
      case LimitExceededFailure:
        return '⚡';
      case ConfigurationFailure:
        return '⚙️';
      default:
        return '⚠️';
    }
  }
}
