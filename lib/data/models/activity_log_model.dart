import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/firebase_constants.dart';

// نموذج سجل الأنشطة
class ActivityLogModel {
  final String id;                    // معرف السجل
  final String userId;                // معرف المستخدم
  final String? applicationId;        // معرف الطلب (اختياري)
  final String action;                // نوع الإجراء
  final DateTime timestamp;           // وقت الإجراء
  final String details;               // تفاصيل الإجراء
  final String? userAgent;            // معلومات المتصفح (اختياري)
  final String? ipAddress;            // عنوان IP (اختياري)
  final Map<String, dynamic>? metadata; // بيانات إضافية

  const ActivityLogModel({
    required this.id,
    required this.userId,
    this.applicationId,
    required this.action,
    required this.timestamp,
    required this.details,
    this.userAgent,
    this.ipAddress,
    this.metadata,
  });

  // تحويل من JSON إلى Model
  factory ActivityLogModel.fromJson(Map<String, dynamic> json) {
    return ActivityLogModel(
      id: json['id'] ?? '',
      userId: json[FirebaseConstants.userId] ?? '',
      applicationId: json[FirebaseConstants.applicationId],
      action: json[FirebaseConstants.logAction] ?? '',
      timestamp: (json[FirebaseConstants.logTimestamp] as Timestamp?)?.toDate() ?? DateTime.now(),
      details: json[FirebaseConstants.logDetails] ?? '',
      userAgent: json[FirebaseConstants.logUserAgent],
      ipAddress: json[FirebaseConstants.logIpAddress],
      metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
    );
  }

  // تحويل من Firestore Document إلى Model
  factory ActivityLogModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ActivityLogModel.fromJson({...data, 'id': doc.id});
  }

  // تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      FirebaseConstants.userId: userId,
      if (applicationId != null) FirebaseConstants.applicationId: applicationId,
      FirebaseConstants.logAction: action,
      FirebaseConstants.logTimestamp: Timestamp.fromDate(timestamp),
      FirebaseConstants.logDetails: details,
      if (userAgent != null) FirebaseConstants.logUserAgent: userAgent,
      if (ipAddress != null) FirebaseConstants.logIpAddress: ipAddress,
      if (metadata != null) 'metadata': metadata,
    };
  }

  // تحويل إلى JSON للـ Firestore (بدون ID)
  Map<String, dynamic> toFirestoreJson() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  // نسخ مع تغيير
  ActivityLogModel copyWith({
    String? id,
    String? userId,
    String? applicationId,
    String? action,
    DateTime? timestamp,
    String? details,
    String? userAgent,
    String? ipAddress,
    Map<String, dynamic>? metadata,
  }) {
    return ActivityLogModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      applicationId: applicationId ?? this.applicationId,
      action: action ?? this.action,
      timestamp: timestamp ?? this.timestamp,
      details: details ?? this.details,
      userAgent: userAgent ?? this.userAgent,
      ipAddress: ipAddress ?? this.ipAddress,
      metadata: metadata ?? this.metadata,
    );
  }

  // إنشاء سجل تسجيل الدخول
  static ActivityLogModel createLoginLog({
    required String userId,
    String? userAgent,
    String? ipAddress,
  }) {
    return ActivityLogModel(
      id: '',
      userId: userId,
      action: FirebaseConstants.actionLogin,
      timestamp: DateTime.now(),
      details: 'تم تسجيل الدخول بنجاح',
      userAgent: userAgent,
      ipAddress: ipAddress,
    );
  }

  // إنشاء سجل تسجيل الخروج
  static ActivityLogModel createLogoutLog({
    required String userId,
    String? userAgent,
    String? ipAddress,
  }) {
    return ActivityLogModel(
      id: '',
      userId: userId,
      action: FirebaseConstants.actionLogout,
      timestamp: DateTime.now(),
      details: 'تم تسجيل الخروج',
      userAgent: userAgent,
      ipAddress: ipAddress,
    );
  }

  // إنشاء سجل إنشاء الحساب
  static ActivityLogModel createRegisterLog({
    required String userId,
    String? userAgent,
    String? ipAddress,
  }) {
    return ActivityLogModel(
      id: '',
      userId: userId,
      action: FirebaseConstants.actionRegister,
      timestamp: DateTime.now(),
      details: 'تم إنشاء الحساب بنجاح',
      userAgent: userAgent,
      ipAddress: ipAddress,
    );
  }

  // إنشاء سجل إرسال الطلب
  static ActivityLogModel createApplicationSubmittedLog({
    required String userId,
    required String applicationId,
    String? userAgent,
    String? ipAddress,
  }) {
    return ActivityLogModel(
      id: '',
      userId: userId,
      applicationId: applicationId,
      action: FirebaseConstants.actionApplicationSubmitted,
      timestamp: DateTime.now(),
      details: 'تم إرسال طلب التعويض',
      userAgent: userAgent,
      ipAddress: ipAddress,
    );
  }

  // إنشاء سجل رفع المستند
  static ActivityLogModel createDocumentUploadedLog({
    required String userId,
    required String applicationId,
    required String documentName,
    String? userAgent,
    String? ipAddress,
  }) {
    return ActivityLogModel(
      id: '',
      userId: userId,
      applicationId: applicationId,
      action: FirebaseConstants.actionDocumentUploaded,
      timestamp: DateTime.now(),
      details: 'تم رفع المستند: $documentName',
      userAgent: userAgent,
      ipAddress: ipAddress,
    );
  }

  // إنشاء سجل تحديث البيانات
  static ActivityLogModel createDataUpdatedLog({
    required String userId,
    required String applicationId,
    required String updateDetails,
    String? userAgent,
    String? ipAddress,
  }) {
    return ActivityLogModel(
      id: '',
      userId: userId,
      applicationId: applicationId,
      action: FirebaseConstants.actionDataUpdated,
      timestamp: DateTime.now(),
      details: 'تم تحديث البيانات: $updateDetails',
      userAgent: userAgent,
      ipAddress: ipAddress,
    );
  }

  // الحصول على رمز الإجراء
  String get actionIcon {
    switch (action) {
      case FirebaseConstants.actionLogin:
        return '🔑';
      case FirebaseConstants.actionLogout:
        return '🚪';
      case FirebaseConstants.actionRegister:
        return '📝';
      case FirebaseConstants.actionApplicationSubmitted:
        return '📨';
      case FirebaseConstants.actionDocumentUploaded:
        return '📎';
      case FirebaseConstants.actionDataUpdated:
        return '✏️';
      default:
        return '📋';
    }
  }

  // الحصول على وصف الإجراء بالعربية
  String get actionDescription {
    switch (action) {
      case FirebaseConstants.actionLogin:
        return 'تسجيل الدخول';
      case FirebaseConstants.actionLogout:
        return 'تسجيل الخروج';
      case FirebaseConstants.actionRegister:
        return 'إنشاء الحساب';
      case FirebaseConstants.actionApplicationSubmitted:
        return 'إرسال الطلب';
      case FirebaseConstants.actionDocumentUploaded:
        return 'رفع المستند';
      case FirebaseConstants.actionDataUpdated:
        return 'تحديث البيانات';
      default:
        return 'إجراء غير معروف';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityLogModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          action == other.action &&
          timestamp == other.timestamp;

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      action.hashCode ^
      timestamp.hashCode;

  @override
  String toString() {
    return 'ActivityLogModel(id: $id, userId: $userId, action: $action, timestamp: $timestamp)';
  }
}
