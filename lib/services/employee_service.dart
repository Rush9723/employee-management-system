import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:employee_management_system/model/employee_model.dart';
import 'package:get/get.dart';

class EmployeeService extends GetConnect implements GetxService {
  Future<List<EmployeeModel>> fetchEmployees() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://669b3f09276e45187d34eb4e.mockapi.io/api/v1/employee'),
      );

      log(response.body.toString());

      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> jResponse = jsonDecode(response.body);
        return jResponse.map((e) => EmployeeModel.fromJson(e)).toList();
      } else {
        // Handle the error response
        log('Error: ${response.statusCode}');
        throw Exception('Failed to load employees');
      }
    } catch (e) {
      log('Exception: $e');
      rethrow;
    }
  }
}
