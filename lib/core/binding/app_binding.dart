import 'package:employee_management_system/controllers/employee_coontroller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../services/employee_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EmployeeController());
    Get.put(EmployeeService());
  }
}
