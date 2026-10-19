import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer_widget.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();
  
  String? _selectedService;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'lib/assets/dr DON-11.JPG',
            fit: BoxFit.cover,
            color: Colors.white.withValues(alpha: 0.42),
            colorBlendMode: BlendMode.srcOver,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [AppColors.primaryDark, AppColors.primary],
                    ),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: const Center(
                    child: Text('Book an Appointment', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 700),
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(                      color: AppColors.surface.withValues(alpha: 0.86), borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)]),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Patient Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
                            const SizedBox(height: 24),
                            _buildTextField(_nameController, 'Full Name', Icons.person),
                            const SizedBox(height: 16),
                            _buildTextField(_phoneController, 'Phone Number', Icons.phone, keyboardType: TextInputType.phone),
                            const SizedBox(height: 24),
                            const Text('Appointment Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
                            const SizedBox(height: 24),
                            DropdownButtonFormField<String>(
                              initialValue: _selectedService,
                              decoration: const InputDecoration(labelText: 'Medical Service', border: OutlineInputBorder(), prefixIcon: Icon(Icons.medical_services)),
                              items: ['General Consultation', 'Cardiology', 'Maternity Care', 'Diagnostics', 'Emergency Triage']
                                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (val) => setState(() => _selectedService = val),
                              validator: (val) => val == null ? 'Please select a service' : null,
                            ),
                            const SizedBox(height: 16),
                            InkWell(
                              onTap: () async {
                                final date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 90)));
                                if (date != null) setState(() => _selectedDate = date);
                              },
                              child: InputDecorator(
                                decoration: const InputDecoration(labelText: 'Preferred Date', border: OutlineInputBorder(), prefixIcon: Icon(Icons.calendar_today)),
                                child: Text(_selectedDate == null ? 'Select a date' : DateFormat('yyyy-MM-dd').format(_selectedDate!)),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(_notesController, 'Additional Notes (Optional)', Icons.note, maxLines: 3),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _submitForm,
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
                                child: const Text('Confirm Booking', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const FooterWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {int maxLines = 1, TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder(), prefixIcon: Icon(icon)),
      validator: (val) => (val == null || val.isEmpty) ? 'This field is required' : null,
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment request submitted successfully! We will contact you shortly.'), backgroundColor: Colors.green),
      );
      // TODO: Integrate Firebase Firestore save here in the next step
    }
  }
}
