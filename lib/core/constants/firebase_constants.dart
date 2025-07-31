// ثوابت Firebase
class FirebaseConstants {
  // مجموعات البيانات
  static const String usersCollection = 'users';
  static const String applicationsCollection = 'applications';
  static const String activityLogsCollection = 'activity_logs';
  
  // حقول المستخدم
  static const String userEmail = 'email';
  static const String userCreatedAt = 'createdAt';
  static const String userLastLogin = 'lastLogin';
  static const String userProfileComplete = 'profileComplete';
  
  // حقول الطلب
  static const String applicationId = 'applicationId';
  static const String userId = 'userId';
  static const String personalData = 'personalData';
  static const String documents = 'documents';
  static const String status = 'status';
  static const String submissionDate = 'submissionDate';
  static const String lastUpdated = 'lastUpdated';
  
  // حقول البيانات الشخصية
  static const String fullNameIraq = 'fullNameIraq';
  static const String motherName = 'motherName';
  static const String currentProvince = 'currentProvince';
  static const String birthDate = 'birthDate';
  static const String birthPlace = 'birthPlace';
  static const String phoneNumber = 'phoneNumber';
  static const String nationalId = 'nationalId';
  static const String nationalIdIssueYear = 'nationalIdIssueYear';
  static const String nationalIdIssuer = 'nationalIdIssuer';
  static const String fullNameKuwait = 'fullNameKuwait';
  static const String kuwaitAddress = 'kuwaitAddress';
  static const String kuwaitEducationLevel = 'kuwaitEducationLevel';
  static const String familyMembersCount = 'familyMembersCount';
  static const String adultsOver18Count = 'adultsOver18Count';
  static const String exitMethod = 'exitMethod';
  static const String compensationTypes = 'compensationTypes';
  static const String kuwaitJobType = 'kuwaitJobType';
  static const String kuwaitOfficialStatus = 'kuwaitOfficialStatus';
  static const String rightsRequestTypes = 'rightsRequestTypes';
  
  // حقول المستندات
  static const String documentName = 'name';
  static const String documentUrl = 'url';
  static const String documentType = 'type';
  static const String documentUploadedAt = 'uploadedAt';
  static const String documentSize = 'size';
  
  // حقول سجل الأنشطة
  static const String logAction = 'action';
  static const String logTimestamp = 'timestamp';
  static const String logDetails = 'details';
  static const String logUserAgent = 'userAgent';
  static const String logIpAddress = 'ipAddress';
  
  // حالات الطلب
  static const String statusUnderReview = 'under_review';
  static const String statusApproved = 'approved';
  static const String statusRejected = 'rejected';
  static const String statusNeedsMoreInfo = 'needs_more_info';
  
  // أنواع الإجراءات في السجل
  static const String actionLogin = 'login';
  static const String actionLogout = 'logout';
  static const String actionRegister = 'register';
  static const String actionApplicationSubmitted = 'application_submitted';
  static const String actionDocumentUploaded = 'document_uploaded';
  static const String actionDataUpdated = 'data_updated';
  
  // مجلدات التخزين
  static const String documentsStoragePath = 'documents';
  static const String profilePhotosStoragePath = 'profile_photos';
  static const String certificatesStoragePath = 'certificates';
  
  // أسماء المستندات
  static const String personalPhotoDoc = 'personal_photo';
  static const String iraqiAffairsDoc = 'iraqi_affairs_dept';
  static const String kuwaitImmigrationDoc = 'kuwait_immigration';
  static const String validResidenceDoc = 'valid_residence';
  static const String redCrossDoc = 'red_cross_international';
}
