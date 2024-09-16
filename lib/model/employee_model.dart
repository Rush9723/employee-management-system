class EmployeeModel {
  String? createdAt;
  String? name;
  String? avatar;
  String? emailId;
  String? mobile;
  String? country;
  String? state;
  String? district;
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  EmployeeModel({
    this.createdAt,
    this.name,
    this.avatar,
    this.emailId,
    this.mobile,
    this.country,
    this.state,
    this.district,
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
  });

  // Factory constructor to create an EmployeeModel from JSON
  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      createdAt: json['createdAt'] ?? 'N/A',
      name: json['name'] ?? 'N/A',
      avatar: json['avatar'] ?? 'N/A',
      emailId: json['emailId'] ?? 'N/A',
      mobile: json['mobile'] ?? 'N/A',
      country: json['country'] ?? 'N/A',
      state: json['state'] ?? 'N/A',
      district: json['district'] ?? 'N/A',
      id: json['id'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
      firstName: json['first_name'] ?? 'N/A',
      lastName: json['last_name'] ?? 'N/A',
      phoneNumber: json['phone_number'] ?? 'N/A',
    );
  }

  // Method to convert EmployeeModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'name': name,
      'avatar': avatar,
      'emailId': emailId,
      'mobile': mobile,
      'country': country,
      'state': state,
      'district': district,
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
    };
  }
}
