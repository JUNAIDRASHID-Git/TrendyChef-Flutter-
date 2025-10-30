import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trendychef/Presentation/checkout/bloc/check_out_bloc.dart';
import 'package:trendychef/Presentation/widgets/address_row/bloc/address_bloc.dart';
import 'package:trendychef/Presentation/widgets/textFIelds/text_field.dart';
import 'package:trendychef/core/services/models/user_model.dart';
import 'package:trendychef/core/l10n/app_localizations.dart';

void showEditDialog(BuildContext context, Address address, String phone) {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController(text: phone);
  final streetController = TextEditingController(text: address.street);
  final cityController = TextEditingController(text: address.city);
  final stateController = TextEditingController(text: address.state);
  final postalCodeController = TextEditingController(text: address.postalCode);
  final countryController = TextEditingController(text: "Saudi Arabia");

  final lang = AppLocalizations.of(context)!;

  const List<String> saudiRegions = [
    'Riyadh',
    'Makkah',
    'Madinah',
    'Eastern Province',
    'Qassim',
    'Asir',
    'Tabuk',
    'Hail',
    'Northern Borders',
    'Jazan',
    'Najran',
    'Al Bahah',
    'Al Jawf',
    'Ha\'il',
  ];

  showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (dialogContext) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.blue.shade50],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade600, Colors.blue.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.edit_location_alt_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lang.editAddress,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              lang.updateYourDeliveryInformation,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Form Content
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Phone with +966 prefix
                            buildTextField(
                              controller: phoneController,
                              label: "Phone Number",
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Phone number is required';
                                } else if (!RegExp(
                                  r'^\d{8,12}$',
                                ).hasMatch(value.trim())) {
                                  return 'Enter a valid phone number (8-12 digits)';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            buildTextField(
                              controller: streetController,
                              label: "Street Address",
                              icon: Icons.home_outlined,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Street address is required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            Row(
                              children: [
                                Expanded(
                                  child: buildTextField(
                                    controller: cityController,
                                    label: "City",
                                    icon: Icons.location_city_outlined,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'City is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      final selectedRegion = await showDialog<
                                        String
                                      >(
                                        context: context,
                                        builder:
                                            (context) => Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: SizedBox(
                                                width: 300,
                                                height: 400,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            16,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors
                                                                .blue
                                                                .shade600,
                                                        borderRadius:
                                                            const BorderRadius.only(
                                                              topLeft:
                                                                  Radius.circular(
                                                                    16,
                                                                  ),
                                                              topRight:
                                                                  Radius.circular(
                                                                    16,
                                                                  ),
                                                            ),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          "Select Region",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: ListView.separated(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              16,
                                                            ),
                                                        itemCount:
                                                            saudiRegions.length,
                                                        separatorBuilder:
                                                            (_, _) =>
                                                                const Divider(),
                                                        itemBuilder: (
                                                          context,
                                                          index,
                                                        ) {
                                                          final region =
                                                              saudiRegions[index];
                                                          return ListTile(
                                                            title: Text(region),
                                                            onTap: () {
                                                              Navigator.pop(
                                                                context,
                                                                region,
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      );

                                      if (selectedRegion != null) {
                                        stateController.text = selectedRegion;
                                      }
                                    },
                                    child: AbsorbPointer(
                                      child: buildTextField(
                                        controller: stateController,
                                        label: "Region",
                                        icon: Icons.map_outlined,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Region is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            Row(
                              children: [
                                Expanded(
                                  child: buildTextField(
                                    controller: postalCodeController,
                                    label: "Postal Code",
                                    icon: Icons.local_post_office_outlined,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Postal code is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: buildTextField(
                                    controller: countryController,
                                    label: "Country",
                                    icon: Icons.public_outlined,
                                    enabled: false,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Action Buttons
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => context.pop(),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          child: Text(
                            lang.cancel,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              final updatedAddress = Address(
                                street: streetController.text,
                                city: cityController.text,
                                state: stateController.text,
                                postalCode: postalCodeController.text,
                                country: countryController.text,
                              );

                              final updatedPhone = phoneController.text;
                              final state = context.read<AddressBloc>().state;

                              if (state is AddressLoaded) {
                                final currentUser = state.user;
                                context.read<AddressBloc>().add(
                                  EditAddressEvent(
                                    user: UserModel(
                                      id: currentUser.id,
                                      name: currentUser.name,
                                      phone: updatedPhone,
                                      address: updatedAddress,
                                    ),
                                  ),
                                );
                              }

                              if (state is AddressLoaded) {
                                context.read<CheckOutBloc>().add(
                                  CheckOutFetchEvent(),
                                );
                              }

                              context.pop();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            "Save Changes",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
  );
}
