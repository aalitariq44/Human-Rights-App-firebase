import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/personal_data_entity.dart';
import '../../core/constants/firebase_constants.dart';

// نموذج البيانات الشخصية
class PersonalDataModel extends PersonalDataEntity {
  const PersonalDataModel({
    required super.fullNameIraq,
    required super.motherName,
    required super.currentProvince,
    required super.birthDate,
    required super.birthPlace,
    required super.phoneNumber,
    required super.nationalId,
    required super.nationalIdIssueYear,
    required super.nationalIdIssuer,
    required super.fullNameKuwait,
    required super.kuwaitAddress,
    required super.kuwaitEducationLevel,
    required super.familyMembersCount,
    required super.adultsOver18Count,
    required super.exitMethod,
    required super.compensationTypes,
    required super.kuwaitJobType,
    required super.kuwaitOfficialStatus,
    required super.rightsRequestTypes,
    required super.hasIraqiAffairsDept,
    required super.hasKuwaitImmigration,
    required super.hasValidResidence,
    required super.hasRedCrossInternational,
    required super.submissionDate,
    required super.applicationId,
    required super.applicationStatus,
  });

  // تحويل من Entity إلى Model
  factory PersonalDataModel.fromEntity(PersonalDataEntity entity) {
    return PersonalDataModel(
      fullNameIraq: entity.fullNameIraq,
      motherName: entity.motherName,
      currentProvince: entity.currentProvince,
      birthDate: entity.birthDate,
      birthPlace: entity.birthPlace,
      phoneNumber: entity.phoneNumber,
      nationalId: entity.nationalId,
      nationalIdIssueYear: entity.nationalIdIssueYear,
      nationalIdIssuer: entity.nationalIdIssuer,
      fullNameKuwait: entity.fullNameKuwait,
      kuwaitAddress: entity.kuwaitAddress,
      kuwaitEducationLevel: entity.kuwaitEducationLevel,
      familyMembersCount: entity.familyMembersCount,
      adultsOver18Count: entity.adultsOver18Count,
      exitMethod: entity.exitMethod,
      compensationTypes: entity.compensationTypes,
      kuwaitJobType: entity.kuwaitJobType,
      kuwaitOfficialStatus: entity.kuwaitOfficialStatus,
      rightsRequestTypes: entity.rightsRequestTypes,
      hasIraqiAffairsDept: entity.hasIraqiAffairsDept,
      hasKuwaitImmigration: entity.hasKuwaitImmigration,
      hasValidResidence: entity.hasValidResidence,
      hasRedCrossInternational: entity.hasRedCrossInternational,
      submissionDate: entity.submissionDate,
      applicationId: entity.applicationId,
      applicationStatus: entity.applicationStatus,
    );
  }

  // تحويل من JSON إلى Model
  factory PersonalDataModel.fromJson(Map<String, dynamic> json) {
    return PersonalDataModel(
      fullNameIraq: json[FirebaseConstants.fullNameIraq] ?? '',
      motherName: json[FirebaseConstants.motherName] ?? '',
      currentProvince: json[FirebaseConstants.currentProvince] ?? '',
      birthDate: (json[FirebaseConstants.birthDate] as Timestamp).toDate(),
      birthPlace: json[FirebaseConstants.birthPlace] ?? '',
      phoneNumber: json[FirebaseConstants.phoneNumber] ?? '',
      nationalId: json[FirebaseConstants.nationalId] ?? '',
      nationalIdIssueYear: json[FirebaseConstants.nationalIdIssueYear] ?? 0,
      nationalIdIssuer: json[FirebaseConstants.nationalIdIssuer] ?? '',
      fullNameKuwait: json[FirebaseConstants.fullNameKuwait] ?? '',
      kuwaitAddress: json[FirebaseConstants.kuwaitAddress] ?? '',
      kuwaitEducationLevel: json[FirebaseConstants.kuwaitEducationLevel] ?? '',
      familyMembersCount: json[FirebaseConstants.familyMembersCount] ?? 0,
      adultsOver18Count: json[FirebaseConstants.adultsOver18Count] ?? 0,
      exitMethod: _parseExitMethod(json[FirebaseConstants.exitMethod]),
      compensationTypes: _parseCompensationTypes(json[FirebaseConstants.compensationTypes]),
      kuwaitJobType: _parseKuwaitJobType(json[FirebaseConstants.kuwaitJobType]),
      kuwaitOfficialStatus: _parseKuwaitOfficialStatus(json[FirebaseConstants.kuwaitOfficialStatus]),
      rightsRequestTypes: _parseRightsRequestTypes(json[FirebaseConstants.rightsRequestTypes]),
      hasIraqiAffairsDept: json['hasIraqiAffairsDept'] ?? false,
      hasKuwaitImmigration: json['hasKuwaitImmigration'] ?? false,
      hasValidResidence: json['hasValidResidence'] ?? false,
      hasRedCrossInternational: json['hasRedCrossInternational'] ?? false,
      submissionDate: (json[FirebaseConstants.submissionDate] as Timestamp).toDate(),
      applicationId: json[FirebaseConstants.applicationId] ?? '',
      applicationStatus: _parseApplicationStatus(json[FirebaseConstants.status]),
    );
  }

  // تحويل من Firestore Document إلى Model
  factory PersonalDataModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PersonalDataModel.fromJson(data);
  }

  // تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      FirebaseConstants.fullNameIraq: fullNameIraq,
      FirebaseConstants.motherName: motherName,
      FirebaseConstants.currentProvince: currentProvince,
      FirebaseConstants.birthDate: Timestamp.fromDate(birthDate),
      FirebaseConstants.birthPlace: birthPlace,
      FirebaseConstants.phoneNumber: phoneNumber,
      FirebaseConstants.nationalId: nationalId,
      FirebaseConstants.nationalIdIssueYear: nationalIdIssueYear,
      FirebaseConstants.nationalIdIssuer: nationalIdIssuer,
      FirebaseConstants.fullNameKuwait: fullNameKuwait,
      FirebaseConstants.kuwaitAddress: kuwaitAddress,
      FirebaseConstants.kuwaitEducationLevel: kuwaitEducationLevel,
      FirebaseConstants.familyMembersCount: familyMembersCount,
      FirebaseConstants.adultsOver18Count: adultsOver18Count,
      FirebaseConstants.exitMethod: exitMethod.name,
      FirebaseConstants.compensationTypes: compensationTypes.map((e) => e.name).toList(),
      FirebaseConstants.kuwaitJobType: kuwaitJobType.name,
      FirebaseConstants.kuwaitOfficialStatus: kuwaitOfficialStatus.name,
      FirebaseConstants.rightsRequestTypes: rightsRequestTypes.map((e) => e.name).toList(),
      'hasIraqiAffairsDept': hasIraqiAffairsDept,
      'hasKuwaitImmigration': hasKuwaitImmigration,
      'hasValidResidence': hasValidResidence,
      'hasRedCrossInternational': hasRedCrossInternational,
      FirebaseConstants.submissionDate: Timestamp.fromDate(submissionDate),
      FirebaseConstants.applicationId: applicationId,
      FirebaseConstants.status: applicationStatus.name,
    };
  }

  // تحويل إلى Entity
  PersonalDataEntity toEntity() {
    return PersonalDataEntity(
      fullNameIraq: fullNameIraq,
      motherName: motherName,
      currentProvince: currentProvince,
      birthDate: birthDate,
      birthPlace: birthPlace,
      phoneNumber: phoneNumber,
      nationalId: nationalId,
      nationalIdIssueYear: nationalIdIssueYear,
      nationalIdIssuer: nationalIdIssuer,
      fullNameKuwait: fullNameKuwait,
      kuwaitAddress: kuwaitAddress,
      kuwaitEducationLevel: kuwaitEducationLevel,
      familyMembersCount: familyMembersCount,
      adultsOver18Count: adultsOver18Count,
      exitMethod: exitMethod,
      compensationTypes: compensationTypes,
      kuwaitJobType: kuwaitJobType,
      kuwaitOfficialStatus: kuwaitOfficialStatus,
      rightsRequestTypes: rightsRequestTypes,
      hasIraqiAffairsDept: hasIraqiAffairsDept,
      hasKuwaitImmigration: hasKuwaitImmigration,
      hasValidResidence: hasValidResidence,
      hasRedCrossInternational: hasRedCrossInternational,
      submissionDate: submissionDate,
      applicationId: applicationId,
      applicationStatus: applicationStatus,
    );
  }

  // دوال مساعدة لتحليل التعدادات
  static ExitMethod _parseExitMethod(dynamic value) {
    if (value is String) {
      return ExitMethod.values.firstWhere(
        (e) => e.name == value,
        orElse: () => ExitMethod.voluntaryDeparture,
      );
    }
    return ExitMethod.voluntaryDeparture;
  }

  static List<CompensationType> _parseCompensationTypes(dynamic value) {
    if (value is List) {
      return value
          .map((e) => CompensationType.values.firstWhere(
                (type) => type.name == e,
                orElse: () => CompensationType.moralCompensation,
              ))
          .toList();
    }
    return [CompensationType.moralCompensation];
  }

  static KuwaitJobType _parseKuwaitJobType(dynamic value) {
    if (value is String) {
      return KuwaitJobType.values.firstWhere(
        (e) => e.name == value,
        orElse: () => KuwaitJobType.civilEmployee,
      );
    }
    return KuwaitJobType.civilEmployee;
  }

  static KuwaitOfficialStatus _parseKuwaitOfficialStatus(dynamic value) {
    if (value is String) {
      return KuwaitOfficialStatus.values.firstWhere(
        (e) => e.name == value,
        orElse: () => KuwaitOfficialStatus.resident,
      );
    }
    return KuwaitOfficialStatus.resident;
  }

  static List<RightsRequestType> _parseRightsRequestTypes(dynamic value) {
    if (value is List) {
      return value
          .map((e) => RightsRequestType.values.firstWhere(
                (type) => type.name == e,
                orElse: () => RightsRequestType.pensionSalary,
              ))
          .toList();
    }
    return [RightsRequestType.pensionSalary];
  }

  static ApplicationStatus _parseApplicationStatus(dynamic value) {
    if (value is String) {
      return ApplicationStatus.values.firstWhere(
        (e) => e.name == value,
        orElse: () => ApplicationStatus.underReview,
      );
    }
    return ApplicationStatus.underReview;
  }

  @override
  PersonalDataModel copyWith({
    String? fullNameIraq,
    String? motherName,
    String? currentProvince,
    DateTime? birthDate,
    String? birthPlace,
    String? phoneNumber,
    String? nationalId,
    int? nationalIdIssueYear,
    String? nationalIdIssuer,
    String? fullNameKuwait,
    String? kuwaitAddress,
    String? kuwaitEducationLevel,
    int? familyMembersCount,
    int? adultsOver18Count,
    ExitMethod? exitMethod,
    List<CompensationType>? compensationTypes,
    KuwaitJobType? kuwaitJobType,
    KuwaitOfficialStatus? kuwaitOfficialStatus,
    List<RightsRequestType>? rightsRequestTypes,
    bool? hasIraqiAffairsDept,
    bool? hasKuwaitImmigration,
    bool? hasValidResidence,
    bool? hasRedCrossInternational,
    DateTime? submissionDate,
    String? applicationId,
    ApplicationStatus? applicationStatus,
  }) {
    return PersonalDataModel(
      fullNameIraq: fullNameIraq ?? this.fullNameIraq,
      motherName: motherName ?? this.motherName,
      currentProvince: currentProvince ?? this.currentProvince,
      birthDate: birthDate ?? this.birthDate,
      birthPlace: birthPlace ?? this.birthPlace,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      nationalId: nationalId ?? this.nationalId,
      nationalIdIssueYear: nationalIdIssueYear ?? this.nationalIdIssueYear,
      nationalIdIssuer: nationalIdIssuer ?? this.nationalIdIssuer,
      fullNameKuwait: fullNameKuwait ?? this.fullNameKuwait,
      kuwaitAddress: kuwaitAddress ?? this.kuwaitAddress,
      kuwaitEducationLevel: kuwaitEducationLevel ?? this.kuwaitEducationLevel,
      familyMembersCount: familyMembersCount ?? this.familyMembersCount,
      adultsOver18Count: adultsOver18Count ?? this.adultsOver18Count,
      exitMethod: exitMethod ?? this.exitMethod,
      compensationTypes: compensationTypes ?? this.compensationTypes,
      kuwaitJobType: kuwaitJobType ?? this.kuwaitJobType,
      kuwaitOfficialStatus: kuwaitOfficialStatus ?? this.kuwaitOfficialStatus,
      rightsRequestTypes: rightsRequestTypes ?? this.rightsRequestTypes,
      hasIraqiAffairsDept: hasIraqiAffairsDept ?? this.hasIraqiAffairsDept,
      hasKuwaitImmigration: hasKuwaitImmigration ?? this.hasKuwaitImmigration,
      hasValidResidence: hasValidResidence ?? this.hasValidResidence,
      hasRedCrossInternational: hasRedCrossInternational ?? this.hasRedCrossInternational,
      submissionDate: submissionDate ?? this.submissionDate,
      applicationId: applicationId ?? this.applicationId,
      applicationStatus: applicationStatus ?? this.applicationStatus,
    );
  }
}
