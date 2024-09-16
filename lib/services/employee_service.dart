import 'dart:developer';
import 'dart:io';

import 'package:employee_management_system/model/employee_model.dart';
import 'package:get/get.dart';

class EmployeeService extends GetConnect implements GetxService {
  Future<List<EmployeeModel>> fetchEmployees() async {
    try {
      Response response = await get(
          'https://669b3f09276e45187d34eb4e.mockapi.io/api/v1/employee');
      log(response.body.toString());
      if (response.status.hasError) {
        log(response.body.toString());
        throw response.body.toString();
      } else {
        final jResponse = response.body as List<dynamic>;
        final data = jResponse.map((e) => EmployeeModel.fromJson(e)).toList();
        log(data.toString());
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }
}
