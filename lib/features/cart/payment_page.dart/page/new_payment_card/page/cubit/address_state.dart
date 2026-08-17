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
final class AddingLocation extends AddressInitial{}
final class LocationAdded extends AddressInitial{}
final class LocationAddingFailure extends AddressInitial{}
final class LocationChosen extends AddressInitial{
  final AddressModel location;

  LocationChosen({required this.location});
}
final class ConfirmAddressLoading extends AddressInitial{}
final class ConfirmAddressLoaded extends AddressInitial{}
final class ConfirmAddressError extends AddressInitial{
  final String message;

  ConfirmAddressError({required this.message});
}
