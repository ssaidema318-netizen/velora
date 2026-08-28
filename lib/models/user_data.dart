// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserData {
  final String id;
  final String name;
  final String email;
  final String phone;

  UserData({required this.id, required this.name, required this.email, required this.phone});



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String, 
      phone: map['email'] as String, 
    );
  }


}
