// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserData {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? photoUrl;

  UserData({required this.id, required this.name, required this.email, required this.phone, this.photoUrl});



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl':photoUrl
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String, 
      phone: map['phone'] as String, 
      photoUrl: map['photoUrl'] as String?, 
    );
  }
  UserData copyWith({String? photoUrl}) {
    return UserData(
      id: id,
      name: name,
      email: email,
      phone: phone,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }


}
