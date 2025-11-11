import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/widgets/address_row/address_edit_dialog.dart';
import 'package:trendychef/Presentation/widgets/address_row/address_row_info.dart';
import 'package:trendychef/Presentation/widgets/address_row/bloc/address_bloc.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';

class ExpandableAddressRow extends StatefulWidget {
  final bool isExpanded; // initial state
  const ExpandableAddressRow({
    super.key,
    this.isExpanded = false,
  }); // default false

  @override
  State<ExpandableAddressRow> createState() => _ExpandableAddressRowState();
}

class _ExpandableAddressRowState extends State<ExpandableAddressRow> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded; // initialize from widget
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        if (state is! AddressLoaded) {
          return const CircularProgressIndicator();
        }

        final address = state.address;
        final phone = state.phone;

        return GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade50, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.deliveryAddress,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          Text(
                            lang.tapToEditDeliveryInfo,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit_outlined, color: AppColors.primary),
                      onPressed: () async {
                        showEditDialog(context, address, phone);
                      },
                      tooltip: lang.editAddress,
                    ),
                    Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: AppColors.primary,
                    ),
                  ],
                ),

                // Expanded Content
                if (_isExpanded)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (phone.isNotEmpty) ...[
                            buildAddressInfoRow(
                              icon: Icons.phone_outlined,
                              label: lang.phone,
                              value: phone,
                              color: Colors.green,
                            ),
                            const SizedBox(height: 12),
                          ],
                          buildAddressInfoRow(
                            icon: Icons.home_outlined,
                            label: lang.address,
                            value: "${address.street}, ${address.city}",
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 8),
                          buildAddressInfoRow(
                            icon: Icons.location_city_outlined,
                            label: lang.location,
                            value: "${address.state}, ${address.postalCode}",
                            color: Colors.orange,
                          ),
                          const SizedBox(height: 8),
                          buildAddressInfoRow(
                            icon: Icons.public_outlined,
                            label: lang.country,
                            value: address.country,
                            color: Colors.purple,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
