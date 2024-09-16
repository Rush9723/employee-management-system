import 'dart:developer';

import 'package:employee_management_system/services/employee_service.dart';
import 'package:get/get.dart';

import '../model/employee_model.dart';

class EmployeeController extends GetxController {
  RxList<EmployeeModel> employees = <EmployeeModel>[].obs;
  EmployeeService employeeService = EmployeeService();
  Future<bool> fetchEmployees() async {
    try {
      final employeesData = await employeeService.fetchEmployees();
      if (employeesData.isNotEmpty) {
        log(employeesData.toString());
        employees.value = employeesData;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Get.snackbar("Faild to load employees", e.toString());
      return false;
    }
  }
}
