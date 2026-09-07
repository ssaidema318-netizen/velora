import 'package:velora/constants/api_paths.dart';
import 'package:velora/models/address_model.dart';
import 'package:velora/services/firestore_services.dart';

abstract class AddressServices {
  Future<void> addAddress(
    String userId,
    AddressModel address,
  );

  Future<List<AddressModel>> fetchAddresses(
    String userId,
  );

  Stream<List<AddressModel>> watchAddresses(
    String userId,
  );
  Future<void> chooseAddress(
    String userId,
    String addressId,
  );
}

class AddressServicesImpl implements AddressServices {
  final firestoreServices = FirestoreServices.instance;
  @override
Future<void> chooseAddress(
  String userId,
  String addressId,
) async {
  final addresses = await fetchAddresses(userId);

  final updates = addresses.map(
    (address) {
      return (
        path: ApiPaths.address(
          userId,
          address.id,
        ),
        data: {
          'isChosen': address.id == addressId,
        },
      );
    },
  ).toList();

  await firestoreServices.batchUpdateData(updates);
}
  @override
  Future<void> addAddress(
    String userId,
    AddressModel address,
  ) async {
    await firestoreServices.setData(
      path: ApiPaths.address(
        userId,
        address.id,
      ),
      data: address.toMap(),
    );
  }

  @override
  Future<List<AddressModel>> fetchAddresses(
    String userId,
  ) async {
    return await firestoreServices.getCollection(
      path: ApiPaths.addresses(userId),
      builder: (data, documentId) =>
          AddressModel.fromMap(data),
    );
  }

  @override
  Stream<List<AddressModel>> watchAddresses(
    String userId,
  ) {
    return firestoreServices.collectionStream<AddressModel>(
      path: ApiPaths.addresses(userId),
      builder: (data, documentId) =>
          AddressModel.fromMap(data),
    );
  }
}