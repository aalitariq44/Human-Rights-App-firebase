import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../constants/storage_constants.dart';
import '../constants/app_constants.dart';

// فئة مساعدة الملفات
class FileHelper {
  // الحصول على امتداد الملف
  static String getFileExtension(String filePath) {
    return path.extension(filePath).toLowerCase().replaceAll('.', '');
  }
  
  // التحقق من نوع الملف
  static bool isImageFile(String filePath) {
    final extension = getFileExtension(filePath);
    return StorageConstants.fileExtensions['image']!.contains(extension);
  }
  
  static bool isDocumentFile(String filePath) {
    final extension = getFileExtension(filePath);
    return StorageConstants.fileExtensions['document']!.contains(extension);
  }
  
  // التحقق من حجم الملف
  static Future<bool> isFileSizeValid(String filePath, {bool isImage = true}) async {
    final file = File(filePath);
    if (!await file.exists()) return false;
    
    final sizeInBytes = await file.length();
    final sizeInMB = sizeInBytes / (1024 * 1024);
    
    if (isImage) {
      return sizeInMB <= AppConstants.maxImageSizeMB;
    } else {
      return sizeInMB <= AppConstants.maxPdfSizeMB;
    }
  }
  
  // الحصول على حجم الملف بالميجابايت
  static Future<double> getFileSizeInMB(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) return 0.0;
    
    final sizeInBytes = await file.length();
    return sizeInBytes / (1024 * 1024);
  }
  
  // ضغط الصورة
  static Future<String?> compressImage(String imagePath, {int quality = 85}) async {
    try {
      final directory = await getTemporaryDirectory();
      final fileName = path.basenameWithoutExtension(imagePath);
      final extension = getFileExtension(imagePath);
      final targetPath = '${directory.path}/compressed_${fileName}_${DateTime.now().millisecondsSinceEpoch}.$extension';
      
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        imagePath,
        targetPath,
        quality: quality,
        minHeight: StorageConstants.fullImageSize,
        minWidth: StorageConstants.fullImageSize,
        keepExif: false,
      );
      
      return compressedFile?.path;
    } catch (e) {
      debugPrint('خطأ في ضغط الصورة: $e');
      return null;
    }
  }
  
  // إنشاء صورة مصغرة
  static Future<String?> createThumbnail(String imagePath) async {
    try {
      final directory = await getTemporaryDirectory();
      final fileName = path.basenameWithoutExtension(imagePath);
      final targetPath = '${directory.path}/thumbnail_${fileName}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      final thumbnailFile = await FlutterImageCompress.compressAndGetFile(
        imagePath,
        targetPath,
        quality: StorageConstants.imageQualityMedium,
        minHeight: StorageConstants.thumbnailSize,
        minWidth: StorageConstants.thumbnailSize,
        keepExif: false,
      );
      
      return thumbnailFile?.path;
    } catch (e) {
      debugPrint('خطأ في إنشاء الصورة المصغرة: $e');
      return null;
    }
  }
  
  // تغيير حجم الصورة
  static Future<Uint8List?> resizeImage(Uint8List imageBytes, int width, int height) async {
    try {
      final image = img.decodeImage(imageBytes);
      if (image == null) return null;
      
      final resized = img.copyResize(image, width: width, height: height);
      return Uint8List.fromList(img.encodeJpg(resized, quality: StorageConstants.imageQualityHigh));
    } catch (e) {
      debugPrint('خطأ في تغيير حجم الصورة: $e');
      return null;
    }
  }
  
  // إنشاء اسم ملف فريد
  static String generateUniqueFileName(String originalFileName, String userId) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = getFileExtension(originalFileName);
    final baseName = path.basenameWithoutExtension(originalFileName);
    return '${userId}_${baseName}_$timestamp.$extension';
  }
  
  // إنشاء مسار محلي للملف
  static Future<String> getLocalFilePath(String fileName, {String? subfolder}) async {
    final directory = await getApplicationDocumentsDirectory();
    final folder = subfolder ?? StorageConstants.documentsDirectory;
    final folderPath = Directory('${directory.path}/$folder');
    
    if (!await folderPath.exists()) {
      await folderPath.create(recursive: true);
    }
    
    return '${folderPath.path}/$fileName';
  }
  
  // نسخ الملف إلى المجلد المحلي
  static Future<String?> copyFileToLocal(String sourcePath, String targetFileName, {String? subfolder}) async {
    try {
      final sourceFile = File(sourcePath);
      if (!await sourceFile.exists()) return null;
      
      final targetPath = await getLocalFilePath(targetFileName, subfolder: subfolder);
      final targetFile = await sourceFile.copy(targetPath);
      
      return targetFile.path;
    } catch (e) {
      debugPrint('خطأ في نسخ الملف: $e');
      return null;
    }
  }
  
  // حذف الملف
  static Future<bool> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('خطأ في حذف الملف: $e');
      return false;
    }
  }
  
  // تنظيف الملفات المؤقتة
  static Future<void> cleanupTempFiles() async {
    try {
      final tempDirectory = await getTemporaryDirectory();
      final tempFiles = tempDirectory.listSync();
      
      for (final file in tempFiles) {
        if (file is File) {
          final fileStats = await file.stat();
          final daysSinceModified = DateTime.now().difference(fileStats.modified).inDays;
          
          if (daysSinceModified > 7) {
            await file.delete();
          }
        }
      }
    } catch (e) {
      debugPrint('خطأ في تنظيف الملفات المؤقتة: $e');
    }
  }
  
  // الحصول على نوع MIME للملف
  static String getMimeType(String filePath) {
    final extension = getFileExtension(filePath);
    
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'txt':
        return 'text/plain';
      default:
        return 'application/octet-stream';
    }
  }
  
  // تحويل حجم الملف إلى نص قابل للقراءة
  static String formatFileSize(double sizeInBytes) {
    if (sizeInBytes < 1024) {
      return '${sizeInBytes.toStringAsFixed(0)} بايت';
    } else if (sizeInBytes < 1024 * 1024) {
      return '${(sizeInBytes / 1024).toStringAsFixed(1)} كيلوبايت';
    } else if (sizeInBytes < 1024 * 1024 * 1024) {
      return '${(sizeInBytes / (1024 * 1024)).toStringAsFixed(1)} ميجابايت';
    } else {
      return '${(sizeInBytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} جيجابايت';
    }
  }
  
  // التحقق من صحة الملف
  static Future<FileValidationResult> validateFile(String filePath, {bool isImage = true}) async {
    final file = File(filePath);
    
    // التحقق من وجود الملف
    if (!await file.exists()) {
      return FileValidationResult(
        isValid: false,
        errorMessage: 'الملف غير موجود',
      );
    }
    
    // التحقق من نوع الملف
    final isCorrectType = isImage ? isImageFile(filePath) : isDocumentFile(filePath);
    if (!isCorrectType) {
      return FileValidationResult(
        isValid: false,
        errorMessage: isImage 
          ? 'نوع الملف غير مدعوم. يرجى اختيار صورة بصيغة JPG أو PNG'
          : 'نوع الملف غير مدعوم. يرجى اختيار ملف PDF',
      );
    }
    
    // التحقق من حجم الملف
    final isSizeValid = await isFileSizeValid(filePath, isImage: isImage);
    if (!isSizeValid) {
      final maxSize = isImage ? AppConstants.maxImageSizeMB : AppConstants.maxPdfSizeMB;
      return FileValidationResult(
        isValid: false,
        errorMessage: 'حجم الملف كبير جداً. الحد الأقصى $maxSize ميجابايت',
      );
    }
    
    return FileValidationResult(isValid: true);
  }
}

// فئة نتيجة التحقق من الملف
class FileValidationResult {
  final bool isValid;
  final String? errorMessage;
  
  FileValidationResult({
    required this.isValid,
    this.errorMessage,
  });
}
