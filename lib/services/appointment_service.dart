import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new appointment
  Future<bool> bookAppointment({
    required String patientId,
    required String doctorId,
    required DateTime date,
    required String time,
    required String notes,
  }) async {
    try {
      await _firestore.collection('appointments').add({
        'patientId': patientId,
        'doctorId': doctorId,
        'date': Timestamp.fromDate(date),
        'time': time,
        'notes': notes,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      debugPrint('Error booking appointment: $e');
      return false;
    }
  }

  // Stream to listen to patient's appointments
  Stream<QuerySnapshot> getPatientAppointments(String patientId) {
    return _firestore
        .collection('appointments')
        .where('patientId', isEqualTo: patientId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}