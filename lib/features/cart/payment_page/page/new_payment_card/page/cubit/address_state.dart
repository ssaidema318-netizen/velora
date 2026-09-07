part of 'address_cubit.dart';

sealed class AddressState {}

final class AddressInitial extends AddressState {}


// ─────────────────────────────────────────────
// Fetch Addresses
// ─────────────────────────────────────────────

final class FetchingAddress extends AddressState {}

final class FetchedAddress extends AddressState {
  final List<AddressModel> address;

  FetchedAddress({
    required this.address,
  });
}

final class FetchAddressError extends AddressState {
  final String message;

  FetchAddressError({
    required this.message,
  });
}


// ─────────────────────────────────────────────
// Add Address
// ─────────────────────────────────────────────

final class AddingLocation extends AddressState {}

final class LocationAdded extends AddressState {}

final class LocationAddingFailure extends AddressState {
  final String message;

  LocationAddingFailure({
    required this.message,
  });
}


// ─────────────────────────────────────────────
// Select Address
// ─────────────────────────────────────────────

final class LocationChosen extends AddressState {
  final AddressModel location;

  LocationChosen({
    required this.location,
  });
}


// ─────────────────────────────────────────────
// Confirm Address
// ─────────────────────────────────────────────

final class ConfirmAddressLoading extends AddressState {}

final class ConfirmAddressLoaded extends AddressState {}

final class ConfirmAddressError extends AddressState {
  final String message;

  ConfirmAddressError({
    required this.message,
  });
}