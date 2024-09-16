import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_management_system/core/constants/label_constants.dart';
import 'package:employee_management_system/screens/employee_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/employee_coontroller.dart';
import '../core/widgets/reusable_searchfield.dart';
import '../model/employee_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchTerm = '';
  TextEditingController textController = TextEditingController();
  EmployeeController employeeController = Get.find();
  bool isLoading = true;
  bool isExpanded = false;

  @override
  void initState() {
    fetchEmployees();
    super.initState();
  }

  fetchEmployees() async {
    try {
      final isEmployeeLoad = await employeeController.fetchEmployees();
      if (isEmployeeLoad) {
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      Get.snackbar(
          backgroundColor: Colors.red,
          "Failed to load employees",
          e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LabelConstants.employeeManagement),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                CustomSearchBar(
                    onSubmitted: (value) {
                      setState(() {
                        searchTerm = value;
                      });
                    },
                    textController: textController),
                Expanded(child: employeeList(employeeController.employees)),
              ],
            ),
    );
  }

  employeeList(List<EmployeeModel> employees) {
    final filteredRecords = employeeController.employees.where((employee) {
      final idMatch = employee.id.toString().contains(searchTerm);
      final nameMatch =
          employee.name!.toLowerCase().contains(searchTerm.toLowerCase());
      return idMatch || nameMatch;
    }).toList();
    return ListView.builder(
      itemCount: filteredRecords.length,
      itemBuilder: (context, index) {
        EmployeeModel employeeModel = filteredRecords[index];
        log("$index. $employeeModel");

        return Padding(
          padding: EdgeInsets.only(
              left: 8.0,
              top: 5,
              right: 8.0,
              bottom: index == filteredRecords.length - 1 ? 8.0 : 0),
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmployeeDetailsScreen(
                            employeeModel: employeeModel,
                          )));
            },
            leading: FutureBuilder<bool>(
              future: File(employeeModel.avatar!).exists(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasData && snapshot.data!) {
                  return CircleAvatar(
                    radius: 25,
                    backgroundImage: FileImage(File(employeeModel.avatar!)),
                  );
                } else {
                  return CircleAvatar(
                    radius: 25,
                    backgroundImage: employeeModel.avatar != null &&
                            employeeModel.avatar!.isNotEmpty &&
                            employeeModel.avatar != 'N/A'
                        ? (employeeModel.avatar!.startsWith('http') ||
                                employeeModel.avatar!.startsWith('https'))
                            ? CachedNetworkImageProvider(employeeModel.avatar!)
                                as ImageProvider
                            : const AssetImage('assets/images/profile.png')
                        : const AssetImage('assets/images/profile.png'),
                  );
                }
              },
            ),
            title: Text(
              employeeModel.name!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID: ${employeeModel.id!}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'District: ${employeeModel.district!}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            tileColor: const Color(0xFFEBE6E0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}
