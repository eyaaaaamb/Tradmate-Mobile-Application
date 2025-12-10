class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;



  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,


  });

  // Factory to convert Firestore document to UserModel
  factory UserModel.fromMap(Map<String, dynamic> data, String docId) {
    return UserModel(
      id: docId,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',


    );
  }

  // Convert UserModel to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,


    };
  }
}
