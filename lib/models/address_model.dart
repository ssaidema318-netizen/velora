// ignore_for_file: public_member_api_docs, sort_constructors_first

class AddressModel {
  final String id;
  final String countery;
  final String city;
  final bool isChosen;
  AddressModel({required this.id, required this.countery, required this.city, this.isChosen = false});
  
  AddressModel copyWith({String? id, String? countery, String? city, bool? isChosen}) {
    return AddressModel(
      id: id ?? this.id,
      countery: countery ?? this.countery,
      city: city ?? this.city,
      isChosen: isChosen ?? this.isChosen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'countery': countery,
      'city': city,
      'isChosen': isChosen,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as String,
      countery: map['countery'] as String,
      city: map['city'] as String,
      isChosen: map['isChosen'] as bool,
    );
  }


}
final List<AddressModel> dummyAddress =[];