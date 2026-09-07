import 'package:velora/constants/api_paths.dart';
import 'package:velora/models/payment_model.dart';
import 'package:velora/services/firestore_services.dart';

abstract class CheckoutServices {
  Future<void> addNewCard(
    String userId,
    PaymentModel paymentCard,
  );

  Future<List<PaymentModel>> featchPaymentCard(
    String userId,
  );

  Stream<List<PaymentModel>> watchPaymentCards(
    String userId,
  );

  Future<void> choosePaymentMethod(
    String userId,
    String paymentId,
  );
}

class CheckoutServicesImpel implements CheckoutServices {
  final firestoreServices = FirestoreServices.instance;
   @override
  Future<List<PaymentModel>> featchPaymentCard(
    String userId,
  ) async {
    return await firestoreServices.getCollection(
      path: ApiPaths.paymentCards(userId),
      builder: (data, documentId) =>
          PaymentModel.fromMap(data),
    );
  }
 @override
Future<void> addNewCard(
  String userId,
  PaymentModel paymentCard,
) async {
  final existingCards = await featchPaymentCard(userId);

  final cardToSave = paymentCard.copyWith(
    isChosen: existingCards.isEmpty,
  );

  await firestoreServices.setData(
    path: ApiPaths.paymentCard(
      userId,
      paymentCard.id,
    ),
    data: cardToSave.toMap(),
  );
}

 

  @override
  Stream<List<PaymentModel>> watchPaymentCards(
    String userId,
  ) {
    return firestoreServices.collectionStream<PaymentModel>(
      path: ApiPaths.paymentCards(userId),
      builder: (data, documentId) {
        return PaymentModel.fromMap(data);
      },
    );
  }

  @override
  Future<void> choosePaymentMethod(
    String userId,
    String paymentId,
  ) async {
    final cards = await featchPaymentCard(userId);

    final updates = cards.map(
      (card) {
        return (
          path: ApiPaths.paymentCard(
            userId,
            card.id,
          ),
          data: {
            'isChoiSen': card.id == paymentId,
          },
        );
      },
    ).toList();

    await firestoreServices.batchUpdateData(updates);
  }
}