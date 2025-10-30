import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/profile/pages/dash_board/bloc/user_dash_bloc.dart';
import 'package:trendychef/Presentation/profile/pages/dash_board/bloc/user_dash_event.dart';
import 'package:trendychef/Presentation/profile/pages/dash_board/bloc/user_dash_state.dart';
import 'package:trendychef/Presentation/widgets/address_row/address_row_container.dart';
import 'package:trendychef/Presentation/widgets/address_row/bloc/address_bloc.dart';
import 'package:trendychef/Presentation/widgets/indicators/circular_progress_with_logo.dart';
import 'package:trendychef/core/l10n/app_localizations.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserDashBloc()..add(UserDashFetchEvent()),
        ),
        BlocProvider(
          create: (context) => AddressBloc()..add(FetchAddressEvent()),
        ),
      ],
      child: BlocBuilder<UserDashBloc, UserDashState>(
        builder: (context, state) {
          if (state is UserDashLoading) {
            return Center(child: circularPrgIndicatorWithLogo());
          } else if (state is UserDashLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Use Wrap for responsive layout
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildRow(
                        lang.totalCartedProducts,
                        "${state.items.length}",
                        Colors.deepPurple,
                        Icons.shopping_cart,
                      ),
                      _buildRow(
                        lang.totalPurchased,
                        "${state.totalPurchased.toStringAsFixed(2)} SAR",
                        Colors.green,
                        Icons.monetization_on,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  ExpandableAddressRow(),

                  const SizedBox(height: 10),
                ],
              ),
            );
          } else if (state is UserDashError) {
            return Center(
              child: Text(
                "❌ ${state.message}",
                style: const TextStyle(fontSize: 14, color: Colors.red),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildRow(
    String title,
    String value,
    Color valueColor,
    IconData icon,
  ) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: valueColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: valueColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
