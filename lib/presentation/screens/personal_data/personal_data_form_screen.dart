import 'package:flutter/material.dart';
import '../../../domain/entities/personal_data_entity.dart';

// شاشة نموذج البيانات الشخصية
class PersonalDataFormScreen extends StatefulWidget {
  const PersonalDataFormScreen({super.key});

  @override
  State<PersonalDataFormScreen> createState() => _PersonalDataFormScreenState();
}

class _PersonalDataFormScreenState extends State<PersonalDataFormScreen> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  
  // متحكمات النصوص
  final _fullNameIraqController = TextEditingController();
  final _motherNameController = TextEditingController();
  final _currentProvinceController = TextEditingController();
  final _birthPlaceController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _nationalIdIssueYearController = TextEditingController();
  final _nationalIdIssuerController = TextEditingController();
  final _fullNameKuwaitController = TextEditingController();
  final _kuwaitAddressController = TextEditingController();
  final _kuwaitEducationLevelController = TextEditingController();
  final _familyMembersCountController = TextEditingController();
  final _adultsOver18CountController = TextEditingController();

  // البيانات المختارة
  DateTime? _birthDate;
  ExitMethod? _exitMethod;
  List<CompensationType> _compensationTypes = [];
  KuwaitJobType? _kuwaitJobType;
  KuwaitOfficialStatus? _kuwaitOfficialStatus;
  List<RightsRequestType> _rightsRequestTypes = [];
  
  // الوثائق
  bool _hasIraqiAffairsDept = false;
  bool _hasKuwaitImmigration = false;
  bool _hasValidResidence = false;
  bool _hasRedCrossInternational = false;

  @override
  void dispose() {
    _fullNameIraqController.dispose();
    _motherNameController.dispose();
    _currentProvinceController.dispose();
    _birthPlaceController.dispose();
    _phoneNumberController.dispose();
    _nationalIdController.dispose();
    _nationalIdIssueYearController.dispose();
    _nationalIdIssuerController.dispose();
    _fullNameKuwaitController.dispose();
    _kuwaitAddressController.dispose();
    _kuwaitEducationLevelController.dispose();
    _familyMembersCountController.dispose();
    _adultsOver18CountController.dispose();
    super.dispose();
  }

  // التنقل للخطوة التالية
  void _nextStep() {
    if (_currentStep < 5) {
      setState(() {
        _currentStep++;
      });
    }
  }

  // التنقل للخطوة السابقة
  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  // التحقق من صحة الخطوة الحالية
  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0: // البيانات الأساسية
        return _fullNameIraqController.text.isNotEmpty &&
               _motherNameController.text.isNotEmpty &&
               _currentProvinceController.text.isNotEmpty &&
               _birthDate != null &&
               _birthPlaceController.text.isNotEmpty &&
               _phoneNumberController.text.isNotEmpty;
      case 1: // بيانات البطاقة الوطنية
        return _nationalIdController.text.isNotEmpty &&
               _nationalIdIssueYearController.text.isNotEmpty &&
               _nationalIdIssuerController.text.isNotEmpty;
      case 2: // بيانات الكويت السابقة
        return _fullNameKuwaitController.text.isNotEmpty &&
               _kuwaitAddressController.text.isNotEmpty &&
               _kuwaitEducationLevelController.text.isNotEmpty &&
               _familyMembersCountController.text.isNotEmpty &&
               _adultsOver18CountController.text.isNotEmpty;
      case 3: // خيارات الخروج والتعويض
        return _exitMethod != null &&
               _compensationTypes.isNotEmpty &&
               _kuwaitJobType != null &&
               _kuwaitOfficialStatus != null &&
               _rightsRequestTypes.isNotEmpty;
      case 4: // رفع المستندات
        return true; // الوثائق اختيارية
      case 5: // مراجعة وإرسال
        return true;
      default:
        return false;
    }
  }

  // إرسال البيانات
  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      // إنشاء كائن البيانات الشخصية
      final personalData = PersonalDataEntity(
        fullNameIraq: _fullNameIraqController.text,
        motherName: _motherNameController.text,
        currentProvince: _currentProvinceController.text,
        birthDate: _birthDate!,
        birthPlace: _birthPlaceController.text,
        phoneNumber: _phoneNumberController.text,
        nationalId: _nationalIdController.text,
        nationalIdIssueYear: int.parse(_nationalIdIssueYearController.text),
        nationalIdIssuer: _nationalIdIssuerController.text,
        fullNameKuwait: _fullNameKuwaitController.text,
        kuwaitAddress: _kuwaitAddressController.text,
        kuwaitEducationLevel: _kuwaitEducationLevelController.text,
        familyMembersCount: int.parse(_familyMembersCountController.text),
        adultsOver18Count: int.parse(_adultsOver18CountController.text),
        exitMethod: _exitMethod!,
        compensationTypes: _compensationTypes,
        kuwaitJobType: _kuwaitJobType!,
        kuwaitOfficialStatus: _kuwaitOfficialStatus!,
        rightsRequestTypes: _rightsRequestTypes,
        hasIraqiAffairsDept: _hasIraqiAffairsDept,
        hasKuwaitImmigration: _hasKuwaitImmigration,
        hasValidResidence: _hasValidResidence,
        hasRedCrossInternational: _hasRedCrossInternational,
        submissionDate: DateTime.now(),
        applicationId: 'APP${DateTime.now().millisecondsSinceEpoch}',
        applicationStatus: ApplicationStatus.underReview,
      );

      // محاكاة إرسال البيانات
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إرسال البيانات بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل إرسال البيانات: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('البيانات الشخصية'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xFF1976D2),
            ),
          ),
          child: Stepper(
            currentStep: _currentStep,
            onStepTapped: (step) {
              setState(() {
                _currentStep = step;
              });
            },
            controlsBuilder: (context, details) {
              return Container(
                margin: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    if (details.stepIndex > 0)
                      TextButton(
                        onPressed: _previousStep,
                        child: const Text('السابق'),
                      ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (details.stepIndex == 5) {
                          _submitData();
                        } else if (_validateCurrentStep()) {
                          _nextStep();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('يرجى إكمال جميع الحقول المطلوبة'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(details.stepIndex == 5 ? 'إرسال' : 'التالي'),
                    ),
                  ],
                ),
              );
            },
            steps: [
              // الخطوة الأولى: البيانات الأساسية
              Step(
                title: const Text('البيانات الأساسية'),
                content: _buildBasicDataStep(),
                isActive: _currentStep >= 0,
              ),
              
              // الخطوة الثانية: بيانات البطاقة الوطنية
              Step(
                title: const Text('البطاقة الوطنية'),
                content: _buildNationalIdStep(),
                isActive: _currentStep >= 1,
              ),
              
              // الخطوة الثالثة: بيانات الكويت السابقة
              Step(
                title: const Text('بيانات الكويت السابقة'),
                content: _buildKuwaitDataStep(),
                isActive: _currentStep >= 2,
              ),
              
              // الخطوة الرابعة: خيارات الخروج والتعويض
              Step(
                title: const Text('التعويض والخروج'),
                content: _buildCompensationStep(),
                isActive: _currentStep >= 3,
              ),
              
              // الخطوة الخامسة: رفع المستندات
              Step(
                title: const Text('المستندات'),
                content: _buildDocumentsStep(),
                isActive: _currentStep >= 4,
              ),
              
              // الخطوة السادسة: مراجعة وإرسال
              Step(
                title: const Text('مراجعة وإرسال'),
                content: _buildReviewStep(),
                isActive: _currentStep >= 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // بناء خطوة البيانات الأساسية
  Widget _buildBasicDataStep() {
    return Column(
      children: [
        TextFormField(
          controller: _fullNameIraqController,
          decoration: const InputDecoration(
            labelText: 'الاسم الرباعي واللقب في العراق *',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الاسم الكامل مطلوب';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _motherNameController,
          decoration: const InputDecoration(
            labelText: 'اسم الأم الثلاثي *',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'اسم الأم مطلوب';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _currentProvinceController,
          decoration: const InputDecoration(
            labelText: 'المحافظة حالياً *',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'المحافظة مطلوبة';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        // حقل تاريخ الميلاد
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: _birthDate ?? DateTime(1980),
              firstDate: DateTime(1930),
              lastDate: DateTime.now().subtract(const Duration(days: 365 * 16)),
            );
            if (date != null) {
              setState(() {
                _birthDate = date;
              });
            }
          },
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: 'تاريخ الميلاد *',
              border: OutlineInputBorder(),
            ),
            child: Text(
              _birthDate != null 
                  ? '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}'
                  : 'اختر تاريخ الميلاد',
              style: TextStyle(
                color: _birthDate != null ? Colors.black87 : Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _birthPlaceController,
          decoration: const InputDecoration(
            labelText: 'مكان الميلاد *',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'مكان الميلاد مطلوب';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _phoneNumberController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'رقم الهاتف *',
            border: OutlineInputBorder(),
            hintText: '07901234567',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'رقم الهاتف مطلوب';
            }
            return null;
          },
        ),
      ],
    );
  }

  // بناء خطوة البطاقة الوطنية
  Widget _buildNationalIdStep() {
    return Column(
      children: [
        TextFormField(
          controller: _nationalIdController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'رقم البطاقة الوطنية *',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'رقم البطاقة الوطنية مطلوب';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _nationalIdIssueYearController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'سنة الإصدار *',
            border: OutlineInputBorder(),
            hintText: '2020',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'سنة الإصدار مطلوبة';
            }
            final year = int.tryParse(value);
            if (year == null || year < 1950 || year > DateTime.now().year) {
              return 'سنة الإصدار غير صحيحة';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _nationalIdIssuerController,
          decoration: const InputDecoration(
            labelText: 'جهة الإصدار *',
            border: OutlineInputBorder(),
            hintText: 'مديرية الأحوال المدنية',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'جهة الإصدار مطلوبة';
            }
            return null;
          },
        ),
      ],
    );
  }

  // بناء خطوة بيانات الكويت السابقة
  Widget _buildKuwaitDataStep() {
    return Column(
      children: [
        TextFormField(
          controller: _fullNameKuwaitController,
          decoration: const InputDecoration(
            labelText: 'الاسم الرباعي واللقب في الكويت سابقاً *',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الاسم في الكويت مطلوب';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _kuwaitAddressController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'عنوان السكن في الكويت سابقاً *',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'عنوان السكن في الكويت مطلوب';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _kuwaitEducationLevelController,
          decoration: const InputDecoration(
            labelText: 'التحصيل الدراسي في الكويت *',
            border: OutlineInputBorder(),
            hintText: 'ابتدائية، متوسطة، ثانوية، جامعة',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'التحصيل الدراسي مطلوب';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _familyMembersCountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'عدد أفراد الأسرة حال الخروج من الكويت *',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'عدد أفراد الأسرة مطلوب';
            }
            final count = int.tryParse(value);
            if (count == null || count < 1) {
              return 'العدد غير صحيح';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        TextFormField(
          controller: _adultsOver18CountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'عدد من تم الـ18 عام حال الخروج من الكويت *',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'عدد البالغين مطلوب';
            }
            final count = int.tryParse(value);
            if (count == null || count < 0) {
              return 'العدد غير صحيح';
            }
            return null;
          },
        ),
      ],
    );
  }

  // بناء خطوة التعويض والخروج
  Widget _buildCompensationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // طريقة الخروج من الكويت
        const Text(
          'طريقة الخروج من دولة الكويت *',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ...ExitMethod.values.map((method) => RadioListTile<ExitMethod>(
          title: Text(method.arabicName),
          value: method,
          groupValue: _exitMethod,
          onChanged: (value) {
            setState(() {
              _exitMethod = value;
            });
          },
        )),
        
        const SizedBox(height: 16),
        
        // نوع طلب التعويض
        const Text(
          'نوع طلب التعويض *',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ...CompensationType.values.map((type) => CheckboxListTile(
          title: Text(type.arabicName),
          value: _compensationTypes.contains(type),
          onChanged: (checked) {
            setState(() {
              if (checked == true) {
                _compensationTypes.add(type);
              } else {
                _compensationTypes.remove(type);
              }
            });
          },
        )),
        
        const SizedBox(height: 16),
        
        // طبيعة العمل في الكويت
        const Text(
          'طبيعة العمل في دولة الكويت سابقاً *',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ...KuwaitJobType.values.map((job) => RadioListTile<KuwaitJobType>(
          title: Text(job.arabicName),
          value: job,
          groupValue: _kuwaitJobType,
          onChanged: (value) {
            setState(() {
              _kuwaitJobType = value;
            });
          },
        )),
        
        const SizedBox(height: 16),
        
        // الوضع الرسمي بالكويت
        const Text(
          'الوضع الرسمي بالكويت *',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ...KuwaitOfficialStatus.values.map((status) => RadioListTile<KuwaitOfficialStatus>(
          title: Text(status.arabicName),
          value: status,
          groupValue: _kuwaitOfficialStatus,
          onChanged: (value) {
            setState(() {
              _kuwaitOfficialStatus = value;
            });
          },
        )),
        
        const SizedBox(height: 16),
        
        // نوع طلب الحقوق
        const Text(
          'نوع طلب الحقوق *',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ...RightsRequestType.values.map((right) => CheckboxListTile(
          title: Text(right.arabicName),
          value: _rightsRequestTypes.contains(right),
          onChanged: (checked) {
            setState(() {
              if (checked == true) {
                _rightsRequestTypes.add(right);
              } else {
                _rightsRequestTypes.remove(right);
              }
            });
          },
        )),
      ],
    );
  }

  // بناء خطوة المستندات
  Widget _buildDocumentsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'المستمسكات الثبوتية (اختيارية)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        
        CheckboxListTile(
          title: const Text('دائرة شؤون العراقي'),
          subtitle: const Text('وثيقة من دائرة شؤون العراقي'),
          value: _hasIraqiAffairsDept,
          onChanged: (value) {
            setState(() {
              _hasIraqiAffairsDept = value ?? false;
            });
          },
        ),
        
        CheckboxListTile(
          title: const Text('منفذ الهجرة الكويتية'),
          subtitle: const Text('وثيقة من منفذ الهجرة الكويتية'),
          value: _hasKuwaitImmigration,
          onChanged: (value) {
            setState(() {
              _hasKuwaitImmigration = value ?? false;
            });
          },
        ),
        
        CheckboxListTile(
          title: const Text('إقامة سارية المفعول'),
          subtitle: const Text('نسخة من الإقامة السارية'),
          value: _hasValidResidence,
          onChanged: (value) {
            setState(() {
              _hasValidResidence = value ?? false;
            });
          },
        ),
        
        CheckboxListTile(
          title: const Text('الصليب الأحمر الدولي'),
          subtitle: const Text('وثيقة من الصليب الأحمر الدولي'),
          value: _hasRedCrossInternational,
          onChanged: (value) {
            setState(() {
              _hasRedCrossInternational = value ?? false;
            });
          },
        ),
        
        const SizedBox(height: 16),
        
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Column(
            children: [
              const Icon(Icons.info_outline, color: Colors.blue),
              const SizedBox(height: 8),
              const Text(
                'ملاحظة: يمكنك رفع المستندات لاحقاً من خلال قسم المستندات',
                style: TextStyle(color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // بناء خطوة المراجعة
  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'مراجعة البيانات',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        
        _buildReviewSection('البيانات الأساسية', [
          'الاسم في العراق: ${_fullNameIraqController.text}',
          'اسم الأم: ${_motherNameController.text}',
          'المحافظة: ${_currentProvinceController.text}',
          'تاريخ الميلاد: ${_birthDate != null ? "${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}" : ""}',
          'مكان الميلاد: ${_birthPlaceController.text}',
          'رقم الهاتف: ${_phoneNumberController.text}',
        ]),
        
        _buildReviewSection('البطاقة الوطنية', [
          'رقم البطاقة: ${_nationalIdController.text}',
          'سنة الإصدار: ${_nationalIdIssueYearController.text}',
          'جهة الإصدار: ${_nationalIdIssuerController.text}',
        ]),
        
        _buildReviewSection('بيانات الكويت السابقة', [
          'الاسم في الكويت: ${_fullNameKuwaitController.text}',
          'العنوان: ${_kuwaitAddressController.text}',
          'التحصيل الدراسي: ${_kuwaitEducationLevelController.text}',
          'عدد أفراد الأسرة: ${_familyMembersCountController.text}',
          'عدد البالغين: ${_adultsOver18CountController.text}',
        ]),
        
        _buildReviewSection('التعويض والخروج', [
          'طريقة الخروج: ${_exitMethod?.arabicName ?? ""}',
          'أنواع التعويض: ${_compensationTypes.map((e) => e.arabicName).join(", ")}',
          'نوع العمل: ${_kuwaitJobType?.arabicName ?? ""}',
          'الوضع الرسمي: ${_kuwaitOfficialStatus?.arabicName ?? ""}',
          'أنواع الحقوق: ${_rightsRequestTypes.map((e) => e.arabicName).join(", ")}',
        ]),
        
        const SizedBox(height: 24),
        
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green[200]!),
          ),
          child: const Column(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.green, size: 32),
              SizedBox(height: 8),
              Text(
                'تأكد من صحة جميع البيانات قبل الإرسال',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                'لن تتمكن من تعديل البيانات بعد الإرسال',
                style: TextStyle(color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // بناء قسم المراجعة
  Widget _buildReviewSection(String title, List<String> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1976D2),
            ),
          ),
          const SizedBox(height: 8),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(item, style: const TextStyle(fontSize: 14)),
          )),
        ],
      ),
    );
  }
}
