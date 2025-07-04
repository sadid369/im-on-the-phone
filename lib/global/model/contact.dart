class Contact {
  String? id;
  String firstName;
  String lastName;
  String phoneNumber;
  String message;
  String? profileImagePath;
  String? voiceFilePath;
  String? voiceFileName;
  String? themeId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Contact({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.message,
    this.profileImagePath,
    this.voiceFilePath,
    this.voiceFileName,
    this.themeId,
    this.createdAt,
    this.updatedAt,
  });

  String get fullName => '$firstName $lastName'.trim();
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'message': message,
      'profileImagePath': profileImagePath,
      'voiceFilePath': voiceFilePath,
      'voiceFileName': voiceFileName,
      'themeId': themeId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      message: json['message'] ?? '',
      profileImagePath: json['profileImagePath'],
      voiceFilePath: json['voiceFilePath'],
      voiceFileName: json['voiceFileName'],
      themeId: json['themeId'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}