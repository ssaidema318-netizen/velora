class PaymentModel {
  final String id;
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final bool isChoiSen;

  PaymentModel({
    required this.id,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    this.isChoiSen = false,
  });

  PaymentModel copyWith({
    String? id,
    String? cardHolderName,
    String? cardNumber,
    String? expiryDate,
    String? cvv,
    bool? isChoiSen,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      isChoiSen: isChoiSen ?? this.isChoiSen,
    );
  }
}

List<PaymentModel> dummyPayment = [];
