import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velora/constants/app_colors.dart';
import 'package:velora/constants/app_spacing.dart';
import 'package:velora/features/cart/payment_page.dart/page/new_payment_card/page/cubit/address_cubit.dart';
import 'package:velora/features/cart/payment_page.dart/page/new_payment_card/widgets/location_item.dart';

class ChooseAddressPage extends StatefulWidget {
  const ChooseAddressPage({super.key});

  @override
  State<ChooseAddressPage> createState() => _ChooseAddressPageState();
}

class _ChooseAddressPageState extends State<ChooseAddressPage> {
  late final TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit()..fetchAddress(),
      child: Scaffold(
        appBar: AppBar(title: const Center(child: Text("Address"))),
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.m),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose Your Location",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  "Let's find an unforgettable event. Choose a location below to get started:",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: AppColors.textHint),
                ),
                const SizedBox(height: AppSpacing.l),

                // Input TextField Block
                BlocConsumer<AddressCubit, AddressState>(
                  listenWhen: (previous, current) => current is LocationAdded|| current is ConfirmAddressLoaded,
                  listener: (context, state) {
                    if(state is ConfirmAddressLoaded ){
                 
                      Navigator.of(context).pop(true);
                    }
                    else if (state is LocationAdded) {
                      _locationController.clear();
                    }
                  },
                  builder: (context, state) {
                    return TextField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_on),
                        suffixIcon: state is AddingLocation
                            ? const IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.success,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  if (_locationController.text.isNotEmpty) {
                                    context.read<AddressCubit>().addNewAddress(
                                      _locationController.text,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Enter your location"),
                                      ),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.add),
                              ),
                        hintText: "Write your location:City-Country",
                        filled: true,
                        fillColor: AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: AppColors.textHint,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: AppColors.border,
                            width: 4,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: AppColors.primaryLight,
                            width: 4,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: AppColors.error,
                            width: 4,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: AppColors.error,
                            width: 4,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.l,
                          vertical: AppSpacing.l,
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppSpacing.l),
                Text(
                  "Select Location",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.m),

                // Addresses List Block
                BlocBuilder<AddressCubit, AddressState>(
                  builder: (context, state) {
                    if (state is FetchingAddress) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }

                    if (state is FetchAddressError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is FetchedAddress) {
                      final locations = state.address;
                      if (locations.isEmpty) {
                        return const Center(child: Text("No addresses found"));
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: locations.length,
                        itemBuilder: (context, index) {
                          final item = locations[index];

                          return BlocBuilder<AddressCubit, AddressState>(
                            buildWhen: (previous, current) =>
                                current is LocationChosen,
                            builder: (context, state) {
                              if (state is LocationChosen) {
                                return LocationItem(
                                  onTap: () {
                                    context.read<AddressCubit>().selectLocation(
                                      item.id,
                                    );
                                  },
                                  location: item,
                                  color: state.location.id == item.id
                                      ? AppColors.primary
                                      : AppColors.iconSecondary,
                                );
                              }
                              return LocationItem(
                                onTap: () {
                                  context.read<AddressCubit>().selectLocation(
                                    item.id,
                                  );
                                },
                                location: item,
                              );
                            },
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),

                const SizedBox(height: AppSpacing.l),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<AddressCubit, AddressState>(
                    buildWhen: (previous, current) =>
                        current is ConfirmAddressError ||
                        current is ConfirmAddressLoaded ||
                        current is ConfirmAddressLoading,
                    builder: (context, state) {
                      if(state is ConfirmAddressLoading){ return ElevatedButton(
                        onPressed: null,
                        
                        child: const CircularProgressIndicator.adaptive(),
                      );}
                      return ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AddressCubit>(context).confirmAddress();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.surface,
                        ),
                        child: const Text("confirm"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
