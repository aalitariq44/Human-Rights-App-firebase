// تعداد طريقة الخروج من الكويت
enum ExitMethod {
  voluntaryDeparture('مغادرة طوعية'),
  forcedDeportation('إبعاد قسري'),
  landSmuggling('تهريب عن طريق البر'),
  beforeArmyWithdrawal('قبل انسحاب الجيش');

  const ExitMethod(this.arabicName);
  final String arabicName;
}

// تعداد نوع التعويض
enum CompensationType {
  governmentJobServices('خدمات جراء الوظيفة الحكومية'),
  personalFurnitureProperty('أثاث وممتلكات شخصية'),
  moralCompensation('تعويض معنوي'),
  prisonCompensation('تعويض عن السجن بلا تهمة');

  const CompensationType(this.arabicName);
  final String arabicName;
}

// تعداد نوع العمل في الكويت
enum KuwaitJobType {
  civilEmployee('موظف مدني'),
  militaryEmployee('موظف عسكري'),
  student('طالب'),
  freelance('أعمال حرة');

  const KuwaitJobType(this.arabicName);
  final String arabicName;
}

// تعداد الوضع الرسمي في الكويت
enum KuwaitOfficialStatus {
  resident('مقيم'),
  bidoon('بدون');

  const KuwaitOfficialStatus(this.arabicName);
  final String arabicName;
}

// تعداد نوع طلب الحقوق
enum RightsRequestType {
  pensionSalary('راتب تقاعدي'),
  residentialLand('قطعة أرض سكنية');

  const RightsRequestType(this.arabicName);
  final String arabicName;
}

// تعداد حالة الطلب
enum ApplicationStatus {
  underReview('قيد المراجعة'),
  approved('مقبول'),
  rejected('مرفوض'),
  needsMoreInfo('يحتاج معلومات إضافية');

  const ApplicationStatus(this.arabicName);
  final String arabicName;
}

// كيان البيانات الشخصية
class PersonalDataEntity {
  // البيانات الأساسية
  final String fullNameIraq;           // الاسم الرباعي واللقب في العراق
  final String motherName;             // اسم الأم
  final String currentProvince;        // المحافظة حالياً
  final DateTime birthDate;            // تاريخ الميلاد
  final String birthPlace;             // مكان الميلاد
  final String phoneNumber;            // رقم الهاتف

  // بيانات البطاقة الوطنية
  final String nationalId;             // رقم البطاقة الوطنية
  final int nationalIdIssueYear;       // سنة الإصدار
  final String nationalIdIssuer;       // جهة الإصدار

  // بيانات الكويت السابقة
  final String fullNameKuwait;         // الاسم الرباعي واللقب في دولة الكويت سابقاً
  final String kuwaitAddress;          // عنوان السكن في دولة الكويت سابقاً
  final String kuwaitEducationLevel;   // التحصيل الدراسي في الكويت
  final int familyMembersCount;        // عدد أفراد الأسرة حال الخروج من الكويت
  final int adultsOver18Count;         // عدد من تم الـ18 عام حال الخروج من الكويت

  // خيارات متعددة (Multiple Choice)
  final ExitMethod exitMethod;         // طريقة الخروج من دولة الكويت
  final List<CompensationType> compensationTypes; // نوع طلب التعويض
  final KuwaitJobType kuwaitJobType;   // طبيعة العمل في دولة الكويت سابقاً
  final KuwaitOfficialStatus kuwaitOfficialStatus; // الوضع الرسمي بالكويت
  final List<RightsRequestType> rightsRequestTypes; // نوع طلب الحقوق

  // المستمسكات الثبوتية (Boolean)
  final bool hasIraqiAffairsDept;      // دائرة شؤون العراقي
  final bool hasKuwaitImmigration;     // منفذ الهجرة الكويتية
  final bool hasValidResidence;        // إقامة سارية المفعول
  final bool hasRedCrossInternational; // الصليب الأحمر الدولي

  // معلومات إضافية للمؤسسة
  final DateTime submissionDate;       // تاريخ تقديم الطلب
  final String applicationId;          // رقم الطلب الفريد
  final ApplicationStatus applicationStatus; // حالة الطلب

  const PersonalDataEntity({
    required this.fullNameIraq,
    required this.motherName,
    required this.currentProvince,
    required this.birthDate,
    required this.birthPlace,
    required this.phoneNumber,
    required this.nationalId,
    required this.nationalIdIssueYear,
    required this.nationalIdIssuer,
    required this.fullNameKuwait,
    required this.kuwaitAddress,
    required this.kuwaitEducationLevel,
    required this.familyMembersCount,
    required this.adultsOver18Count,
    required this.exitMethod,
    required this.compensationTypes,
    required this.kuwaitJobType,
    required this.kuwaitOfficialStatus,
    required this.rightsRequestTypes,
    required this.hasIraqiAffairsDept,
    required this.hasKuwaitImmigration,
    required this.hasValidResidence,
    required this.hasRedCrossInternational,
    required this.submissionDate,
    required this.applicationId,
    required this.applicationStatus,
  });

  // نسخ مع تغيير
  PersonalDataEntity copyWith({
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
    return PersonalDataEntity(
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalDataEntity &&
          runtimeType == other.runtimeType &&
          fullNameIraq == other.fullNameIraq &&
          motherName == other.motherName &&
          nationalId == other.nationalId &&
          applicationId == other.applicationId;

  @override
  int get hashCode =>
      fullNameIraq.hashCode ^
      motherName.hashCode ^
      nationalId.hashCode ^
      applicationId.hashCode;

  @override
  String toString() {
    return 'PersonalDataEntity(fullNameIraq: $fullNameIraq, nationalId: $nationalId, applicationId: $applicationId)';
  }
}
