import 'package:form_validator/form_validator.dart';

// فئة التحقق من البيانات
class Validators {
  // التحقق من البريد الإلكتروني
  static String? validateEmail(String? value) {
    return ValidationBuilder()
        .required('البريد الإلكتروني مطلوب')
        .email('صيغة البريد الإلكتروني غير صحيحة')
        .build()(value);
  }
  
  // التحقق من كلمة المرور
  static String? validatePassword(String? value) {
    return ValidationBuilder()
        .required('كلمة المرور مطلوبة')
        .minLength(8, 'كلمة المرور يجب أن تكون 8 أحرف على الأقل')
        .regExp(RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]'), 
                'كلمة المرور يجب أن تحتوي على حروف كبيرة وصغيرة وأرقام ورموز خاصة')
        .build()(value);
  }
  
  // التحقق من تأكيد كلمة المرور
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    }
    if (value != password) {
      return 'كلمة المرور غير متطابقة';
    }
    return null;
  }
  
  // التحقق من الاسم الكامل
  static String? validateFullName(String? value) {
    return ValidationBuilder()
        .required('الاسم الكامل مطلوب')
        .minLength(3, 'الاسم يجب أن يكون 3 أحرف على الأقل')
        .maxLength(100, 'الاسم يجب أن يكون أقل من 100 حرف')
        .regExp(RegExp(r'^[\u0600-\u06FF\s]+$'), 'الاسم يجب أن يحتوي على أحرف عربية فقط')
        .build()(value);
  }
  
  // التحقق من رقم الهوية الوطنية
  static String? validateNationalId(String? value) {
    return ValidationBuilder()
        .required('رقم الهوية الوطنية مطلوب')
        .regExp(RegExp(r'^\d{9,12}$'), 'رقم الهوية يجب أن يكون من 9 إلى 12 رقم')
        .build()(value);
  }
  
  // التحقق من رقم الهاتف
  static String? validatePhoneNumber(String? value) {
    return ValidationBuilder()
        .required('رقم الهاتف مطلوب')
        .regExp(RegExp(r'^(\+964|964|0)?[0-9]{10}$'), 'صيغة رقم الهاتف غير صحيحة')
        .build()(value);
  }
  
  // التحقق من اسم الأم
  static String? validateMotherName(String? value) {
    return ValidationBuilder()
        .required('اسم الأم الثلاثي مطلوب')
        .minLength(3, 'اسم الأم يجب أن يكون 3 أحرف على الأقل')
        .maxLength(50, 'اسم الأم يجب أن يكون أقل من 50 حرف')
        .regExp(RegExp(r'^[\u0600-\u06FF\s]+$'), 'اسم الأم يجب أن يحتوي على أحرف عربية فقط')
        .build()(value);
  }
  
  // التحقق من المحافظة
  static String? validateProvince(String? value) {
    return ValidationBuilder()
        .required('المحافظة مطلوبة')
        .minLength(2, 'اسم المحافظة يجب أن يكون حرفين على الأقل')
        .maxLength(30, 'اسم المحافظة يجب أن يكون أقل من 30 حرف')
        .build()(value);
  }
  
  // التحقق من مكان الميلاد
  static String? validateBirthPlace(String? value) {
    return ValidationBuilder()
        .required('مكان الميلاد مطلوب')
        .minLength(2, 'مكان الميلاد يجب أن يكون حرفين على الأقل')
        .maxLength(50, 'مكان الميلاد يجب أن يكون أقل من 50 حرف')
        .build()(value);
  }
  
  // التحقق من سنة الإصدار
  static String? validateIssueYear(String? value) {
    if (value == null || value.isEmpty) {
      return 'سنة الإصدار مطلوبة';
    }
    
    final year = int.tryParse(value);
    if (year == null) {
      return 'سنة الإصدار يجب أن تكون رقم';
    }
    
    final currentYear = DateTime.now().year;
    if (year < 1950 || year > currentYear) {
      return 'سنة الإصدار غير صحيحة';
    }
    
    return null;
  }
  
  // التحقق من جهة الإصدار
  static String? validateIssuer(String? value) {
    return ValidationBuilder()
        .required('جهة الإصدار مطلوبة')
        .minLength(3, 'جهة الإصدار يجب أن تكون 3 أحرف على الأقل')
        .maxLength(50, 'جهة الإصدار يجب أن تكون أقل من 50 حرف')
        .build()(value);
  }
  
  // التحقق من العنوان في الكويت
  static String? validateKuwaitAddress(String? value) {
    return ValidationBuilder()
        .required('عنوان السكن في الكويت مطلوب')
        .minLength(10, 'العنوان يجب أن يكون 10 أحرف على الأقل')
        .maxLength(200, 'العنوان يجب أن يكون أقل من 200 حرف')
        .build()(value);
  }
  
  // التحقق من التحصيل الدراسي
  static String? validateEducationLevel(String? value) {
    return ValidationBuilder()
        .required('التحصيل الدراسي مطلوب')
        .build()(value);
  }
  
  // التحقق من عدد أفراد الأسرة
  static String? validateFamilyMembersCount(String? value) {
    if (value == null || value.isEmpty) {
      return 'عدد أفراد الأسرة مطلوب';
    }
    
    final count = int.tryParse(value);
    if (count == null) {
      return 'عدد أفراد الأسرة يجب أن يكون رقم';
    }
    
    if (count < 1 || count > 50) {
      return 'عدد أفراد الأسرة غير صحيح';
    }
    
    return null;
  }
  
  // التحقق من عدد البالغين فوق 18
  static String? validateAdultsOver18Count(String? value, int? familyCount) {
    if (value == null || value.isEmpty) {
      return 'عدد البالغين فوق 18 عام مطلوب';
    }
    
    final count = int.tryParse(value);
    if (count == null) {
      return 'العدد يجب أن يكون رقم';
    }
    
    if (count < 0) {
      return 'العدد لا يمكن أن يكون سالب';
    }
    
    if (familyCount != null && count > familyCount) {
      return 'عدد البالغين لا يمكن أن يكون أكبر من عدد أفراد الأسرة';
    }
    
    return null;
  }
  
  // التحقق من التاريخ
  static String? validateDate(DateTime? value, {DateTime? minDate, DateTime? maxDate}) {
    if (value == null) {
      return 'التاريخ مطلوب';
    }
    
    if (minDate != null && value.isBefore(minDate)) {
      return 'التاريخ لا يمكن أن يكون قبل ${_formatDate(minDate)}';
    }
    
    if (maxDate != null && value.isAfter(maxDate)) {
      return 'التاريخ لا يمكن أن يكون بعد ${_formatDate(maxDate)}';
    }
    
    return null;
  }
  
  // التحقق من تاريخ الميلاد
  static String? validateBirthDate(DateTime? value) {
    if (value == null) {
      return 'تاريخ الميلاد مطلوب';
    }
    
    final now = DateTime.now();
    final minDate = DateTime(now.year - 100, now.month, now.day);
    final maxDate = DateTime(now.year - 16, now.month, now.day);
    
    if (value.isBefore(minDate)) {
      return 'تاريخ الميلاد غير صحيح';
    }
    
    if (value.isAfter(maxDate)) {
      return 'يجب أن يكون العمر 16 سنة على الأقل';
    }
    
    return null;
  }
  
  // التحقق من القائمة المتعددة الاختيارات
  static String? validateMultipleChoice<T>(List<T>? values, String fieldName) {
    if (values == null || values.isEmpty) {
      return '$fieldName مطلوب';
    }
    return null;
  }
  
  // التحقق من الاختيار الواحد
  static String? validateSingleChoice<T>(T? value, String fieldName) {
    if (value == null) {
      return '$fieldName مطلوب';
    }
    return null;
  }
  
  // دالة تنسيق التاريخ
  static String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
  
  // التحقق من قوة كلمة المرور
  static double getPasswordStrength(String password) {
    double strength = 0.0;
    
    // الطول
    if (password.length >= 8) strength += 0.2;
    if (password.length >= 12) strength += 0.1;
    
    // الأحرف الصغيرة
    if (password.contains(RegExp(r'[a-z]'))) strength += 0.2;
    
    // الأحرف الكبيرة
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.2;
    
    // الأرقام
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.2;
    
    // الرموز الخاصة
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.1;
    
    return strength.clamp(0.0, 1.0);
  }
  
  // الحصول على وصف قوة كلمة المرور
  static String getPasswordStrengthText(double strength) {
    if (strength < 0.3) return 'ضعيفة';
    if (strength < 0.6) return 'متوسطة';
    if (strength < 0.8) return 'جيدة';
    return 'قوية';
  }
}
