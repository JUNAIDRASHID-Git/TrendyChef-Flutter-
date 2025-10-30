import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/profile/pages/dash_board/dash_board.dart';
import 'package:trendychef/Presentation/profile/pages/recent_order/recent_order.dart';
import 'package:trendychef/Presentation/profile/widgets/profile_skelton.dart';
import 'package:trendychef/Presentation/widgets/buttons/log_out_btn/log_out_btn.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/core/services/api/user/get.dart';
import 'package:trendychef/core/services/models/user_model.dart';
import 'package:trendychef/core/l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.fontWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: 20),
              FutureBuilder<UserModel?>(
                future: fetchUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ProfileSkeleton();
                  } else if (snapshot.hasError) {
                    return Center(child: Text("❌ Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(child: Text("User not found"));
                  }

                  final user = snapshot.data!;

                  final imageUrl =
                      user.picture != null && user.picture!.isNotEmpty
                          ? "https://corsproxy.io/?${Uri.encodeFull(user.picture!)}"
                          : null;

                  String greeting(UserModel user) {
                    final hour = DateTime.now().hour;
                    if (hour < 12) return "${lang.goodmorning}, \n${user.name}";
                    if (hour < 18) {
                      return "${lang.goodafternoon}, \n${user.name}";
                    }
                    return "${lang.goodevening}, \n${user.name}";
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: SizedBox(
                            width: 110,
                            height: 110,
                            child: Image.network(
                              imageUrl ?? "",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColors.primary.withOpacity(0.8),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name.isNotEmpty == true
                                  ? greeting(user)
                                  : 'Guest',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              user.email?.isNotEmpty == true
                                  ? user.email!
                                  : (user.phone.isNotEmpty == true
                                      ? user.phone
                                      : ''),
                              style: TextStyle(
                                color: AppColors.fontBlack.withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(height: 10),
                            logOutBtn(context),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Dashboard(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              width: 180,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(15),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      lang.myorders,
                                      style: TextStyle(
                                        color: AppColors.secondary,
                                        fontSize: 18,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.list_alt_rounded,
                                      color: AppColors.secondary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      RecentOrders(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
