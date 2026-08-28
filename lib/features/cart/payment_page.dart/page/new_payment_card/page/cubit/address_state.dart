part of 'address_cubit.dart';

sealed class AddressState {}

final class AddressInitial extends AddressState {}
final class FetchingAddress extends AddressState {}
final class FetchedAddress extends AddressState {
  final List<AddressModel> address;

  FetchedAddress({required this.address});
}
final class FetchAddressError extends AddressState {
  final String message;

  FetchAddressError({required this.message});
}
final class AddingLocation extends AddressState{}
final class LocationAdded extends AddressState{}
final class LocationAddingFailure extends AddressState{}
final class LocationChosen extends AddressState{
  final AddressModel location;

  LocationChosen({required this.location});
}
final class ConfirmAddressLoading extends AddressState{}
final class ConfirmAddressLoaded extends AddressState{}
final class ConfirmAddressError extends AddressState{
  final String message;

  ConfirmAddressError({required this.message});
}
