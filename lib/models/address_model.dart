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
}
final List<AddressModel> dummyAddress =[];