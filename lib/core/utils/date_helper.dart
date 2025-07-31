import 'package:intl/intl.dart';

// فئة مساعدة التواريخ
class DateHelper {
  // تنسيق التاريخ للعرض باللغة العربية
  static String formatDateArabic(DateTime date) {
    final formatter = DateFormat('EEEE، d MMMM yyyy', 'ar');
    return formatter.format(date);
  }
  
  // تنسيق التاريخ المختصر
  static String formatDateShort(DateTime date) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }
  
  // تنسيق التاريخ والوقت
  static String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(dateTime);
  }
  
  // تنسيق الوقت فقط
  static String formatTime(DateTime dateTime) {
    final formatter = DateFormat('HH:mm');
    return formatter.format(dateTime);
  }
  
  // تنسيق التاريخ للقاعدة البيانات
  static String formatDateForDatabase(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
  
  // تنسيق التاريخ والوقت للقاعدة البيانات
  static String formatDateTimeForDatabase(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(dateTime);
  }
  
  // تحويل النص إلى تاريخ
  static DateTime? parseDate(String dateString) {
    try {
      // محاولة تحليل التنسيقات المختلفة
      final formats = [
        DateFormat('dd/MM/yyyy'),
        DateFormat('yyyy-MM-dd'),
        DateFormat('d/M/yyyy'),
        DateFormat('dd-MM-yyyy'),
      ];
      
      for (final format in formats) {
        try {
          return format.parse(dateString);
        } catch (e) {
          continue;
        }
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }
  
  // حساب العمر بالسنوات
  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    
    if (now.month < birthDate.month || 
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    
    return age;
  }
  
  // تحويل العمر إلى نص عربي
  static String formatAge(DateTime birthDate) {
    final age = calculateAge(birthDate);
    
    if (age == 1) {
      return 'سنة واحدة';
    } else if (age == 2) {
      return 'سنتان';
    } else if (age >= 3 && age <= 10) {
      return '$age سنوات';
    } else {
      return '$age سنة';
    }
  }
  
  // الحصول على اسم الشهر بالعربية
  static String getArabicMonthName(int month) {
    const monthNames = [
      'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
    ];
    
    if (month >= 1 && month <= 12) {
      return monthNames[month - 1];
    }
    return '';
  }
  
  // الحصول على اسم اليوم بالعربية
  static String getArabicDayName(int weekday) {
    const dayNames = [
      'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'
    ];
    
    if (weekday >= 1 && weekday <= 7) {
      return dayNames[weekday - 1];
    }
    return '';
  }
  
  // حساب الفرق بين تاريخين بالنص العربي
  static String getTimeDifference(DateTime startDate, DateTime endDate) {
    final difference = endDate.difference(startDate);
    
    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? 'سنة واحدة' : '$years سنوات';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? 'شهر واحد' : '$months أشهر';
    } else if (difference.inDays > 0) {
      return difference.inDays == 1 ? 'يوم واحد' : '${difference.inDays} أيام';
    } else if (difference.inHours > 0) {
      return difference.inHours == 1 ? 'ساعة واحدة' : '${difference.inHours} ساعات';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1 ? 'دقيقة واحدة' : '${difference.inMinutes} دقائق';
    } else {
      return 'الآن';
    }
  }
  
  // تحويل الوقت النسبي (منذ كذا)
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return 'أمس';
      } else if (difference.inDays < 7) {
        return 'منذ ${difference.inDays} أيام';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return weeks == 1 ? 'منذ أسبوع' : 'منذ $weeks أسابيع';
      } else if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return months == 1 ? 'منذ شهر' : 'منذ $months أشهر';
      } else {
        final years = (difference.inDays / 365).floor();
        return years == 1 ? 'منذ سنة' : 'منذ $years سنوات';
      }
    } else if (difference.inHours > 0) {
      return difference.inHours == 1 ? 'منذ ساعة' : 'منذ ${difference.inHours} ساعات';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1 ? 'منذ دقيقة' : 'منذ ${difference.inMinutes} دقائق';
    } else {
      return 'الآن';
    }
  }
  
  // التحقق من صحة التاريخ
  static bool isValidDate(int year, int month, int day) {
    try {
      final date = DateTime(year, month, day);
      return date.year == year && date.month == month && date.day == day;
    } catch (e) {
      return false;
    }
  }
  
  // الحصول على بداية اليوم
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
  
  // الحصول على نهاية اليوم
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }
  
  // الحصول على بداية الشهر
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }
  
  // الحصول على نهاية الشهر
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59, 999);
  }
  
  // الحصول على بداية السنة
  static DateTime startOfYear(DateTime date) {
    return DateTime(date.year, 1, 1);
  }
  
  // الحصول على نهاية السنة
  static DateTime endOfYear(DateTime date) {
    return DateTime(date.year, 12, 31, 23, 59, 59, 999);
  }
  
  // التحقق من كون التاريخ اليوم
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }
  
  // التحقق من كون التاريخ أمس
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year && 
           date.month == yesterday.month && 
           date.day == yesterday.day;
  }
  
  // الحصول على قائمة بالسنوات
  static List<int> getYearsRange(int startYear, int endYear) {
    return List.generate(endYear - startYear + 1, (index) => startYear + index);
  }
  
  // الحصول على عدد أيام الشهر
  static int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
  
  // التحقق من كون السنة كبيسة
  static bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }
}
