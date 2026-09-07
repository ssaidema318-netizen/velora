// ignore_for_file: public_member_api_docs, sort_constructors_first

class PaymentModel {
  final String id;
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final bool isChosen;

  PaymentModel({
    required this.id,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    this.isChosen = false,
  });

  PaymentModel copyWith({
  String? id,
  String? cardHolderName,
  String? cardNumber,
  String? expiryDate,
  String? cvv,
  bool? isChosen,
}) {
  return PaymentModel(
    id: id ?? this.id,
    cardHolderName: cardHolderName ?? this.cardHolderName,
    cardNumber: cardNumber ?? this.cardNumber,
    expiryDate: expiryDate ?? this.expiryDate,
    cvv: cvv ?? this.cvv,
    isChosen: isChosen ?? this.isChosen,
  );
}

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cardHolderName': cardHolderName,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'isChoiSen': isChosen,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'] as String,
      cardHolderName: map['cardHolderName'] as String,
      cardNumber: map['cardNumber'] as String,
      expiryDate: map['expiryDate'] as String,
      cvv: map['cvv'] as String,
      isChosen: map['isChoiSen'] as bool,
    );
  }


}

List<PaymentModel> dummyPayment = [];
