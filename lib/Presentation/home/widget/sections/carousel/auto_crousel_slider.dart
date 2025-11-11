import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trendychef/Presentation/home/widget/sections/carousel/cubit/carousel_cubit.dart';
import 'package:trendychef/Presentation/home/widget/product_detail_dialog/product_detail_dialog.dart';

class AutoSlidingBanner extends StatelessWidget {
  const AutoSlidingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerSliderCubit, BannerSliderState>(
      builder: (context, state) {
        final cubit = context.read<BannerSliderCubit>();
        final loopedBanners = state.banners;
        final isLoading = state.isLoading;

        const double aspectRatio = 16 / 7;

        if (isLoading) {
          return const BannerSkeleton(aspectRatio: aspectRatio);
        }

        if (loopedBanners.isEmpty) {
          return const AspectRatio(
            aspectRatio: aspectRatio,
            child: Center(child: Text("No banners found")),
          );
        }

        return AspectRatio(
          aspectRatio: aspectRatio,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: cubit.controller,
                  itemCount: loopedBanners.length,
                  onPageChanged: (index) {
                    cubit.updatePage(index);
                    // Looping logic for infinite scroll
                    if (index == 0) {
                      Future.delayed(const Duration(milliseconds: 350), () {
                        cubit.controller.jumpToPage(loopedBanners.length - 2);
                      });
                    } else if (index == loopedBanners.length - 1) {
                      Future.delayed(const Duration(milliseconds: 350), () {
                        cubit.controller.jumpToPage(1);
                      });
                    }
                  },
                  itemBuilder: (_, i) {
                    final banner = loopedBanners[i];
                    final imageUrl = banner.imageUrl;
                    final redirectUrl = banner.url;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap:
                              redirectUrl.isNotEmpty
                                  ? () {
                                    try {
                                      final uri = Uri.parse(redirectUrl);
                                      if (uri.path.contains('/product') &&
                                          uri.queryParameters['id'] != null) {
                                        final productId =
                                            uri.queryParameters['id']!;
                                        _openProductDialog(context, productId);
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Invalid product link',
                                            ),
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Could not parse link'),
                                        ),
                                      );
                                    }
                                  }
                                  : null,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.fill,
                            frameBuilder: (context, child, frame, wasSync) {
                              if (wasSync) return child;
                              return AnimatedOpacity(
                                opacity: frame == null ? 0 : 1,
                                duration: const Duration(milliseconds: 500),
                                child: child,
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder:
                                (_, _, _) => Container(
                                  color: Colors.grey.shade300,
                                  child: const Center(child: Icon(Icons.error)),
                                ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Page Indicator
              // SizedBox(height: 8),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: List.generate(loopedBanners.length - 2, (i) {
              //     final isActive = (currentPage - 1) == i;
              //     return AnimatedContainer(
              //       duration: const Duration(milliseconds: 300),
              //       margin: const EdgeInsets.symmetric(horizontal: 4),
              //       height: 8,
              //       width: isActive ? 24 : 8,
              //       decoration: BoxDecoration(
              //         color: isActive ? AppColors.secondary : AppColors.primary,
              //         borderRadius: BorderRadius.circular(4),
              //       ),
              //     );
              //   }),
              // ),
            ],
          ),
        );
      },
    );
  }

  void _openProductDialog(BuildContext context, String productId) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black54,
        pageBuilder:
            (_, _, _) => Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.height * 0.5,
                height: MediaQuery.of(context).size.height * 0.8,
                child: ProductDialogPage(productID: productId),
              ),
            ),
        transitionsBuilder: (_, animation, _, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          );
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: curved, child: child),
          );
        },
      ),
    );
  }
}

class BannerSkeleton extends StatelessWidget {
  final double aspectRatio;

  const BannerSkeleton({super.key, required this.aspectRatio});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
