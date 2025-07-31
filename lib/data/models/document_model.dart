import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/document_entity.dart';
import '../../core/constants/firebase_constants.dart';

// نموذج المستند
class DocumentModel extends DocumentEntity {
  const DocumentModel({
    required super.id,
    required super.name,
    required super.url,
    required super.type,
    required super.localPath,
    required super.sizeInMB,
    required super.uploadedAt,
    required super.isRequired,
    super.description,
    super.thumbnailUrl,
  });

  // تحويل من Entity إلى Model
  factory DocumentModel.fromEntity(DocumentEntity entity) {
    return DocumentModel(
      id: entity.id,
      name: entity.name,
      url: entity.url,
      type: entity.type,
      localPath: entity.localPath,
      sizeInMB: entity.sizeInMB,
      uploadedAt: entity.uploadedAt,
      isRequired: entity.isRequired,
      description: entity.description,
      thumbnailUrl: entity.thumbnailUrl,
    );
  }

  // تحويل من JSON إلى Model
  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'] ?? '',
      name: json[FirebaseConstants.documentName] ?? '',
      url: json[FirebaseConstants.documentUrl] ?? '',
      type: json[FirebaseConstants.documentType] ?? '',
      localPath: json['localPath'] ?? '',
      sizeInMB: (json[FirebaseConstants.documentSize] ?? 0).toDouble(),
      uploadedAt: (json[FirebaseConstants.documentUploadedAt] as Timestamp?)?.toDate() ?? DateTime.now(),
      isRequired: json['isRequired'] ?? false,
      description: json['description'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  // تحويل من Firestore Document إلى Model
  factory DocumentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DocumentModel.fromJson({...data, 'id': doc.id});
  }

  // تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      FirebaseConstants.documentName: name,
      FirebaseConstants.documentUrl: url,
      FirebaseConstants.documentType: type,
      'localPath': localPath,
      FirebaseConstants.documentSize: sizeInMB,
      FirebaseConstants.documentUploadedAt: Timestamp.fromDate(uploadedAt),
      'isRequired': isRequired,
      if (description != null) 'description': description,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
    };
  }

  // تحويل إلى JSON للـ Firestore (بدون ID)
  Map<String, dynamic> toFirestoreJson() {
    final json = toJson();
    json.remove('id');
    json.remove('localPath');
    return json;
  }

  // تحويل إلى Entity
  DocumentEntity toEntity() {
    return DocumentEntity(
      id: id,
      name: name,
      url: url,
      type: type,
      localPath: localPath,
      sizeInMB: sizeInMB,
      uploadedAt: uploadedAt,
      isRequired: isRequired,
      description: description,
      thumbnailUrl: thumbnailUrl,
    );
  }

  @override
  DocumentModel copyWith({
    String? id,
    String? name,
    String? url,
    String? type,
    String? localPath,
    double? sizeInMB,
    DateTime? uploadedAt,
    bool? isRequired,
    String? description,
    String? thumbnailUrl,
  }) {
    return DocumentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      type: type ?? this.type,
      localPath: localPath ?? this.localPath,
      sizeInMB: sizeInMB ?? this.sizeInMB,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      isRequired: isRequired ?? this.isRequired,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  // إنشاء نموذج للصورة الشخصية
  static DocumentModel createPersonalPhoto({
    required String localPath,
    required double sizeInMB,
    String? url,
    String? thumbnailUrl,
  }) {
    return DocumentModel(
      id: FirebaseConstants.personalPhotoDoc,
      name: 'الصورة الشخصية',
      url: url ?? '',
      type: 'image/jpeg',
      localPath: localPath,
      sizeInMB: sizeInMB,
      uploadedAt: DateTime.now(),
      isRequired: true,
      description: 'صورة شخصية حديثة وواضحة',
      thumbnailUrl: thumbnailUrl,
    );
  }

  // إنشاء نموذج لوثيقة دائرة شؤون العراقي
  static DocumentModel createIraqiAffairsDoc({
    required String localPath,
    required double sizeInMB,
    String? url,
  }) {
    return DocumentModel(
      id: FirebaseConstants.iraqiAffairsDoc,
      name: 'وثيقة دائرة شؤون العراقي',
      url: url ?? '',
      type: 'application/pdf',
      localPath: localPath,
      sizeInMB: sizeInMB,
      uploadedAt: DateTime.now(),
      isRequired: false,
      description: 'وثيقة من دائرة شؤون العراقي تثبت الهوية',
    );
  }

  // إنشاء نموذج لوثيقة منفذ الهجرة الكويتية
  static DocumentModel createKuwaitImmigrationDoc({
    required String localPath,
    required double sizeInMB,
    String? url,
  }) {
    return DocumentModel(
      id: FirebaseConstants.kuwaitImmigrationDoc,
      name: 'وثيقة منفذ الهجرة الكويتية',
      url: url ?? '',
      type: 'application/pdf',
      localPath: localPath,
      sizeInMB: sizeInMB,
      uploadedAt: DateTime.now(),
      isRequired: false,
      description: 'وثيقة من منفذ الهجرة الكويتية',
    );
  }

  // إنشاء نموذج للإقامة السارية
  static DocumentModel createValidResidenceDoc({
    required String localPath,
    required double sizeInMB,
    String? url,
  }) {
    return DocumentModel(
      id: FirebaseConstants.validResidenceDoc,
      name: 'إقامة سارية المفعول',
      url: url ?? '',
      type: 'application/pdf',
      localPath: localPath,
      sizeInMB: sizeInMB,
      uploadedAt: DateTime.now(),
      isRequired: false,
      description: 'نسخة من الإقامة السارية المفعول',
    );
  }

  // إنشاء نموذج لوثيقة الصليب الأحمر
  static DocumentModel createRedCrossDoc({
    required String localPath,
    required double sizeInMB,
    String? url,
  }) {
    return DocumentModel(
      id: FirebaseConstants.redCrossDoc,
      name: 'وثيقة الصليب الأحمر الدولي',
      url: url ?? '',
      type: 'application/pdf',
      localPath: localPath,
      sizeInMB: sizeInMB,
      uploadedAt: DateTime.now(),
      isRequired: false,
      description: 'وثيقة من الصليب الأحمر الدولي',
    );
  }
}
