// كيان المستند
class DocumentEntity {
  final String id;                    // معرف المستند
  final String name;                  // اسم المستند
  final String url;                   // رابط المستند في التخزين
  final String type;                  // نوع المستند (MIME type)
  final String localPath;             // المسار المحلي للملف
  final double sizeInMB;              // حجم الملف بالميجابايت
  final DateTime uploadedAt;          // تاريخ الرفع
  final bool isRequired;              // هل المستند مطلوب
  final String? description;          // وصف المستند
  final String? thumbnailUrl;         // رابط الصورة المصغرة (للصور)

  const DocumentEntity({
    required this.id,
    required this.name,
    required this.url,
    required this.type,
    required this.localPath,
    required this.sizeInMB,
    required this.uploadedAt,
    required this.isRequired,
    this.description,
    this.thumbnailUrl,
  });

  // نسخ مع تغيير
  DocumentEntity copyWith({
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
    return DocumentEntity(
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

  // التحقق من كون المستند صورة
  bool get isImage => type.startsWith('image/');

  // التحقق من كون المستند PDF
  bool get isPdf => type == 'application/pdf';

  // الحصول على امتداد الملف
  String get fileExtension {
    if (isImage) {
      if (type.contains('jpeg')) return 'jpg';
      if (type.contains('png')) return 'png';
      if (type.contains('gif')) return 'gif';
    } else if (isPdf) {
      return 'pdf';
    }
    return 'unknown';
  }

  // تنسيق حجم الملف
  String get formattedSize {
    if (sizeInMB < 1) {
      return '${(sizeInMB * 1024).toStringAsFixed(0)} كيلوبايت';
    } else {
      return '${sizeInMB.toStringAsFixed(1)} ميجابايت';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          url == other.url;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ url.hashCode;

  @override
  String toString() {
    return 'DocumentEntity(id: $id, name: $name, type: $type, size: ${formattedSize})';
  }
}
