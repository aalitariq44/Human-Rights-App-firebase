// كيان المستخدم
class UserEntity {
  final String uid;                   // معرف المستخدم الفريد
  final String email;                 // البريد الإلكتروني
  final DateTime createdAt;           // تاريخ إنشاء الحساب
  final DateTime? lastLogin;          // آخر تسجيل دخول
  final bool profileComplete;         // هل البيانات الشخصية مكتملة
  final bool emailVerified;           // هل البريد الإلكتروني مؤكد
  final String? displayName;          // الاسم المعروض
  final String? photoUrl;             // رابط صورة المستخدم
  final Map<String, dynamic>? metadata; // بيانات إضافية

  const UserEntity({
    required this.uid,
    required this.email,
    required this.createdAt,
    this.lastLogin,
    this.profileComplete = false,
    this.emailVerified = false,
    this.displayName,
    this.photoUrl,
    this.metadata,
  });

  // نسخ مع تغيير
  UserEntity copyWith({
    String? uid,
    String? email,
    DateTime? createdAt,
    DateTime? lastLogin,
    bool? profileComplete,
    bool? emailVerified,
    String? displayName,
    String? photoUrl,
    Map<String, dynamic>? metadata,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      profileComplete: profileComplete ?? this.profileComplete,
      emailVerified: emailVerified ?? this.emailVerified,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      metadata: metadata ?? this.metadata,
    );
  }

  // التحقق من كون المستخدم نشط
  bool get isActive => emailVerified;

  // الحصول على الاسم المعروض أو البريد الإلكتروني
  String get displayNameOrEmail => displayName ?? email;

  // حساب عدد أيام العضوية
  int get membershipDays => DateTime.now().difference(createdAt).inDays;

  // التحقق من كون آخر تسجيل دخول حديث (خلال أسبوع)
  bool get isRecentlyActive {
    if (lastLogin == null) return false;
    return DateTime.now().difference(lastLogin!).inDays <= 7;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          email == other.email;

  @override
  int get hashCode => uid.hashCode ^ email.hashCode;

  @override
  String toString() {
    return 'UserEntity(uid: $uid, email: $email, profileComplete: $profileComplete)';
  }
}
