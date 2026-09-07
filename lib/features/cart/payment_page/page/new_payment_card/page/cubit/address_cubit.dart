import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/models/address_model.dart';
import 'package:velora/services/address_services.dart';
import 'package:velora/services/auth_services.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  final AddressServices addressServices = AddressServicesImpl();
  final AuthServices authServices = AuthServicesImpl();

  StreamSubscription<List<AddressModel>>? _addressSubscription;

  List<AddressModel> _addresses = [];

  String? selectedLocationId;

  // ─────────────────────────────────────────────
  // Watch Addresses
  // ─────────────────────────────────────────────

  void watchAddresses() {
    final currentUser = authServices.currentUser();

    if (currentUser == null) {
      emit(
         FetchAddressError(
          message: 'User is not logged in',
        ),
      );
      return;
    }

    emit(FetchingAddress());

    _addressSubscription?.cancel();

    _addressSubscription = addressServices
        .watchAddresses(currentUser.uid)
        .listen(
          (addresses) {
            _addresses = addresses;

            // لو المستخدم لسه مكنش اختار Address
            // اختار أول Address بشكل مؤقت للـ UI
            if (selectedLocationId == null &&
                addresses.isNotEmpty) {
              selectedLocationId = addresses.first.id;
            }

            emit(
              FetchedAddress(
                address: List.from(_addresses),
              ),
            );
          },
          onError: (error) {
            emit(
               FetchAddressError(
                message: error.toString(),
              ),
            );
          },
        );
  }

  // ─────────────────────────────────────────────
  // Add New Address
  // ─────────────────────────────────────────────

  Future<void> addNewAddress(String addresses) async {
    final currentUser = authServices.currentUser();

    if (currentUser == null) {
      emit(
        LocationAddingFailure(
          message: 'User is not logged in',
        ),
      );
      return;
    }

    final addressParts = addresses.split('-');

    if (addressParts.length < 2) {
      emit(
        LocationAddingFailure(
          message: 'Please enter address correctly',
        ),
      );
      return;
    }

    final newAddress = AddressModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      countery: addressParts[0].trim(),
      city: addressParts[1].trim(),
    );

    emit(AddingLocation());

    try {
      await addressServices.addAddress(
        currentUser.uid,
        newAddress,
      );

      emit(LocationAdded());
    } catch (e) {
      emit(
        LocationAddingFailure(
          message: e.toString(),
        ),
      );
    }
  }

  // ─────────────────────────────────────────────
  // Select Address
  // ─────────────────────────────────────────────

  void selectLocation(String id) {
    final exists = _addresses.any(
      (address) => address.id == id,
    );

    if (!exists) return;

    selectedLocationId = id;

    final selectedAddress = _addresses.firstWhere(
      (address) => address.id == id,
    );

    emit(
      LocationChosen(
        location: selectedAddress,
      ),
    );

    emit(
      FetchedAddress(
        address: List.from(_addresses),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Confirm Address
  // ─────────────────────────────────────────────

  Future<void> confirmAddress() async {
    final currentUser = authServices.currentUser();

    if (currentUser == null) {
      emit(
        ConfirmAddressError(
          message: 'User is not logged in',
        ),
      );
      return;
    }

    if (selectedLocationId == null) {
      emit(
        ConfirmAddressError(
          message: 'Please select an address',
        ),
      );
      return;
    }

    emit(ConfirmAddressLoading());

    try {
      await addressServices.chooseAddress(
        currentUser.uid,
        selectedLocationId!,
      );

      emit(ConfirmAddressLoaded());
    } catch (e) {
      emit(
        ConfirmAddressError(
          message: e.toString(),
        ),
      );
    }
  }

  // ─────────────────────────────────────────────
  // Close
  // ─────────────────────────────────────────────

  @override
  Future<void> close() {
    _addressSubscription?.cancel();
    return super.close();
  }
}