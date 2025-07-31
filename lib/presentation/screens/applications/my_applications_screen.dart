import 'package:flutter/material.dart';
import '../../../domain/entities/personal_data_entity.dart';

// شاشة عرض الطلبات المقدمة
class MyApplicationsScreen extends StatefulWidget {
  const MyApplicationsScreen({super.key});

  @override
  State<MyApplicationsScreen> createState() => _MyApplicationsScreenState();
}

class _MyApplicationsScreenState extends State<MyApplicationsScreen> {
  // بيانات وهمية للطلبات
  final List<PersonalDataEntity> _applications = [
    PersonalDataEntity(
      applicationId: 'APP1704067200000',
      fullNameIraq: 'أحمد محمد علي حسن',
      motherName: 'فاطمة عبد الله محمد',
      currentProvince: 'بغداد',
      birthDate: DateTime(1985, 5, 15),
      birthPlace: 'بغداد',
      phoneNumber: '07901234567',
      nationalId: '12345678901',
      nationalIdIssueYear: 2020,
      nationalIdIssuer: 'مديرية الأحوال المدنية',
      fullNameKuwait: 'أحمد محمد علي',
      kuwaitAddress: 'حولي، شارع بيروت، مجمع الأمير',
      kuwaitEducationLevel: 'ثانوية عامة',
      familyMembersCount: 5,
      adultsOver18Count: 3,
      exitMethod: ExitMethod.forcedDeportation,
      compensationTypes: [CompensationType.personalFurnitureProperty, CompensationType.moralCompensation],
      kuwaitJobType: KuwaitJobType.civilEmployee,
      kuwaitOfficialStatus: KuwaitOfficialStatus.resident,
      rightsRequestTypes: [RightsRequestType.pensionSalary, RightsRequestType.residentialLand],
      hasIraqiAffairsDept: true,
      hasKuwaitImmigration: false,
      hasValidResidence: true,
      hasRedCrossInternational: false,
      submissionDate: DateTime.now().subtract(const Duration(days: 15)),
      applicationStatus: ApplicationStatus.underReview,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلباتي'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      body: _applications.isEmpty ? _buildEmptyState() : _buildApplicationsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/personal-data-form');
        },
        backgroundColor: const Color(0xFF1976D2),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // بناء حالة الفراغ
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد طلبات مقدمة',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'قم بتقديم طلب جديد للحصول على التعويض',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/personal-data-form');
            },
            icon: const Icon(Icons.add),
            label: const Text('تقديم طلب جديد'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1976D2),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  // بناء قائمة الطلبات
  Widget _buildApplicationsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _applications.length,
      itemBuilder: (context, index) {
        final application = _applications[index];
        return _buildApplicationCard(application);
      },
    );
  }

  // بناء بطاقة الطلب
  Widget _buildApplicationCard(PersonalDataEntity application) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: InkWell(
        onTap: () => _showApplicationDetails(application),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // رأس البطاقة
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          application.fullNameIraq,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'رقم الطلب: ${application.applicationId}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(application.applicationStatus),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // معلومات أساسية
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    'تاريخ التقديم: ${_formatDate(application.submissionDate)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    'المحافظة: ${application.currentProvince}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              Row(
                children: [
                  Icon(Icons.phone, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    'الهاتف: ${application.phoneNumber}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // أنواع التعويض
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: application.compensationTypes.map((type) => 
                  Chip(
                    label: Text(
                      type.arabicName,
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Colors.blue[100],
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ).toList(),
              ),
              
              const SizedBox(height: 12),
              
              // الإجراءات
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () => _showApplicationDetails(application),
                    icon: const Icon(Icons.visibility, size: 16),
                    label: const Text('عرض التفاصيل'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF1976D2),
                    ),
                  ),
                  
                  if (application.applicationStatus == ApplicationStatus.underReview)
                    TextButton.icon(
                      onPressed: () => _showEditDialog(application),
                      icon: const Icon(Icons.edit, size: 16),
                      label: const Text('تعديل'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.orange,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // بناء رقاقة الحالة
  Widget _buildStatusChip(ApplicationStatus status) {
    Color color;
    String text;
    
    switch (status) {
      case ApplicationStatus.underReview:
        color = Colors.orange;
        text = 'قيد المراجعة';
        break;
      case ApplicationStatus.approved:
        color = Colors.green;
        text = 'موافق عليه';
        break;
      case ApplicationStatus.rejected:
        color = Colors.red;
        text = 'مرفوض';
        break;
      case ApplicationStatus.needsMoreInfo:
        color = Colors.blue;
        text = 'يحتاج معلومات إضافية';
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // عرض تفاصيل الطلب
  void _showApplicationDetails(PersonalDataEntity application) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // رأس النافذة
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'تفاصيل الطلب',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                
                const Divider(),
                
                // البيانات الأساسية
                _buildDetailSection('البيانات الأساسية', [
                  'الاسم في العراق: ${application.fullNameIraq}',
                  'اسم الأم: ${application.motherName}',
                  'المحافظة: ${application.currentProvince}',
                  'تاريخ الميلاد: ${_formatDate(application.birthDate)}',
                  'مكان الميلاد: ${application.birthPlace}',
                  'رقم الهاتف: ${application.phoneNumber}',
                ]),
                
                // البطاقة الوطنية
                _buildDetailSection('البطاقة الوطنية', [
                  'رقم البطاقة: ${application.nationalId}',
                  'سنة الإصدار: ${application.nationalIdIssueYear}',
                  'جهة الإصدار: ${application.nationalIdIssuer}',
                ]),
                
                // بيانات الكويت
                _buildDetailSection('بيانات الكويت السابقة', [
                  'الاسم في الكويت: ${application.fullNameKuwait}',
                  'العنوان: ${application.kuwaitAddress}',
                  'التحصيل الدراسي: ${application.kuwaitEducationLevel}',
                  'عدد أفراد الأسرة: ${application.familyMembersCount}',
                  'عدد البالغين: ${application.adultsOver18Count}',
                ]),
                
                // التعويض والخروج
                _buildDetailSection('التعويض والخروج', [
                  'طريقة الخروج: ${application.exitMethod.arabicName}',
                  'أنواع التعويض: ${application.compensationTypes.map((e) => e.arabicName).join(", ")}',
                  'نوع العمل: ${application.kuwaitJobType.arabicName}',
                  'الوضع الرسمي: ${application.kuwaitOfficialStatus.arabicName}',
                  'أنواع الحقوق: ${application.rightsRequestTypes.map((e) => e.arabicName).join(", ")}',
                ]),
                
                // المستندات
                _buildDetailSection('المستندات', [
                  'دائرة شؤون العراقي: ${application.hasIraqiAffairsDept ? "متوفر" : "غير متوفر"}',
                  'الهجرة الكويتية: ${application.hasKuwaitImmigration ? "متوفر" : "غير متوفر"}',
                  'إقامة سارية: ${application.hasValidResidence ? "متوفر" : "غير متوفر"}',
                  'الصليب الأحمر: ${application.hasRedCrossInternational ? "متوفر" : "غير متوفر"}',
                ]),
                
                const SizedBox(height: 16),
                
                // معلومات الطلب
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'معلومات الطلب',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('رقم الطلب: ${application.applicationId}'),
                      Text('تاريخ التقديم: ${_formatDate(application.submissionDate)}'),
                      Row(
                        children: [
                          const Text('الحالة: '),
                          _buildStatusChip(application.applicationStatus),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // بناء قسم التفاصيل
  Widget _buildDetailSection(String title, List<String> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1976D2),
            ),
          ),
          const SizedBox(height: 8),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text('• $item', style: const TextStyle(fontSize: 14)),
          )),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // عرض نافذة التعديل
  void _showEditDialog(PersonalDataEntity application) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعديل الطلب'),
        content: const Text(
          'هل تريد تعديل هذا الطلب؟\n\nملاحظة: يمكن تعديل الطلبات التي لم تتم مراجعتها بعد فقط.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context, 
                '/personal-data-form',
                arguments: application,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1976D2),
              foregroundColor: Colors.white,
            ),
            child: const Text('تعديل'),
          ),
        ],
      ),
    );
  }

  // تنسيق التاريخ
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
