import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/models/address_model.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  String? selectedLocationId;

  AddressCubit() : super(AddressInitial()) {
    // تهيئة معرف العنوان الأول فقط إذا كانت القائمة غير فارغة
    if (dummyAddress.isNotEmpty) {
      selectedLocationId = dummyAddress.first.id;
    }
  }

  void addNewAddress(String addresses) {
    final addressParts = addresses.split("-");

    // التاكد من وجود القطر والمدينة تجنبًا للـ RangeError
    if (addressParts.length < 2) return;

    final newAddress = AddressModel(
      id: DateTime.now().toIso8601String(),
      countery: addressParts[0].trim(),
      city: addressParts[1].trim(),
    );

    emit(AddingLocation());
    Future.delayed(const Duration(seconds: 1), () {
      dummyAddress.add(newAddress);

      // تعيين العنوان الجديد كـ selected إذا لم يكن هناك عنوان مسبقًا
      selectedLocationId ??= newAddress.id;

      emit(LocationAdded());
      emit(FetchedAddress(address: List.from(dummyAddress)));
    });
  }

  void fetchAddress() {
    emit(FetchingAddress());
    Future.delayed(const Duration(seconds: 1), () {
      emit(FetchedAddress(address: List.from(dummyAddress)));
    });
  }

  void selectLocation(String id) {
    if (dummyAddress.isEmpty) return;

    // البحث مع استخدام orElse تجنبًا لرمي Exception إذا لم يُعثر على الـ id
    final chosenLocation = dummyAddress.firstWhere(
      (element) => element.id == id,
      orElse: () => dummyAddress.first,
    );

    selectedLocationId = chosenLocation.id;
    emit(LocationChosen(location: chosenLocation));
    emit(FetchedAddress(address: dummyAddress));
  }

  void confirmAddress() {
    emit(ConfirmAddressLoading());
    Future.delayed(const Duration(seconds: 2), () {
      final selectedIndex = dummyAddress.indexWhere(
        (test) => test.id == selectedLocationId,
      );
      final previousIndex = dummyAddress.indexWhere(
        (test) => test.isChosen == true,
      );
      if (previousIndex != -1 && previousIndex != selectedIndex) {
        dummyAddress[previousIndex] = dummyAddress[previousIndex].copyWith(
          isChosen: false,
        );
      }
      if (selectedIndex != -1) {
        dummyAddress[selectedIndex] = dummyAddress[selectedIndex].copyWith(
          isChosen: true,
        );
      }

      emit(ConfirmAddressLoaded());
      emit(FetchedAddress(address: List.from(dummyAddress)));
    });
  }
}
