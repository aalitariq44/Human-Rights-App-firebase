import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../domain/entities/user_entity.dart';
import '../../core/constants/firebase_constants.dart';

// نموذج المستخدم
class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.createdAt,
    super.lastLogin,
    super.profileComplete = false,
    super.emailVerified = false,
    super.displayName,
    super.photoUrl,
    super.metadata,
  });

  // تحويل من Entity إلى Model
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      email: entity.email,
      createdAt: entity.createdAt,
      lastLogin: entity.lastLogin,
      profileComplete: entity.profileComplete,
      emailVerified: entity.emailVerified,
      displayName: entity.displayName,
      photoUrl: entity.photoUrl,
      metadata: entity.metadata,
    );
  }

  // تحويل من Firebase User إلى Model
  factory UserModel.fromFirebaseUser(firebase_auth.User firebaseUser) {
    return UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      createdAt: firebaseUser.metadata.creationTime ?? DateTime.now(),
      lastLogin: firebaseUser.metadata.lastSignInTime,
      profileComplete: false,
      emailVerified: firebaseUser.emailVerified,
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
    );
  }

  // تحويل من JSON إلى Model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json[FirebaseConstants.userEmail] ?? '',
      createdAt: (json[FirebaseConstants.userCreatedAt] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastLogin: (json[FirebaseConstants.userLastLogin] as Timestamp?)?.toDate(),
      profileComplete: json[FirebaseConstants.userProfileComplete] ?? false,
      emailVerified: json['emailVerified'] ?? false,
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
      metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
    );
  }

  // تحويل من Firestore Document إلى Model
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel.fromJson({...data, 'uid': doc.id});
  }

  // تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      FirebaseConstants.userEmail: email,
      FirebaseConstants.userCreatedAt: Timestamp.fromDate(createdAt),
      if (lastLogin != null) FirebaseConstants.userLastLogin: Timestamp.fromDate(lastLogin!),
      FirebaseConstants.userProfileComplete: profileComplete,
      'emailVerified': emailVerified,
      if (displayName != null) 'displayName': displayName,
      if (photoUrl != null) 'photoUrl': photoUrl,
      if (metadata != null) 'metadata': metadata,
    };
  }

  // تحويل إلى JSON للـ Firestore (بدون UID)
  Map<String, dynamic> toFirestoreJson() {
    final json = toJson();
    json.remove('uid');
    return json;
  }

  // تحويل إلى Entity
  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      email: email,
      createdAt: createdAt,
      lastLogin: lastLogin,
      profileComplete: profileComplete,
      emailVerified: emailVerified,
      displayName: displayName,
      photoUrl: photoUrl,
      metadata: metadata,
    );
  }

  @override
  UserModel copyWith({
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
    return UserModel(
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

  // تحديث وقت آخر تسجيل دخول
  UserModel updateLastLogin() {
    return copyWith(lastLogin: DateTime.now());
  }

  // تحديث حالة اكتمال البيانات الشخصية
  UserModel updateProfileComplete(bool isComplete) {
    return copyWith(profileComplete: isComplete);
  }

  // إضافة أو تحديث البيانات الإضافية
  UserModel updateMetadata(String key, dynamic value) {
    final newMetadata = Map<String, dynamic>.from(metadata ?? {});
    newMetadata[key] = value;
    return copyWith(metadata: newMetadata);
  }

  // حذف بيانات إضافية
  UserModel removeMetadata(String key) {
    if (metadata == null || !metadata!.containsKey(key)) return this;
    final newMetadata = Map<String, dynamic>.from(metadata!);
    newMetadata.remove(key);
    return copyWith(metadata: newMetadata.isEmpty ? null : newMetadata);
  }
}
