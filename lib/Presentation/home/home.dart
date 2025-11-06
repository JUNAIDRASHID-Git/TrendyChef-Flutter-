import 'dart:ui' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/category/category.dart';
import 'package:trendychef/Presentation/home/bloc/home_event.dart';
import 'package:trendychef/Presentation/home/widget/sections/carousel/cubit/carousel_cubit.dart';
import 'package:trendychef/Presentation/widgets/cards/product_card.dart';
import 'package:trendychef/Presentation/home/widget/shimmer/home_shimmer.dart';
import 'package:trendychef/Presentation/home/widget/sections/carousel/auto_crousel_slider.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/core/services/models/category.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fontWhite,
      body: BlocProvider(
        create: (context) => HomeBloc()..add(LoadCategories()),
        child: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(LoadCategories());
                context.read<BannerSliderCubit>().loadBanners();
                await context.read<HomeBloc>().stream.firstWhere(
                  (state) => state is HomeLoaded || state is HomeError,
                );
              },
              color: AppColors.primary,
              backgroundColor: Colors.white,
              child: BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (p, c) => p != c,
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: HomeSkeletonLoader(),
                    );
                  }

                  if (state is HomeError) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height - 100,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Error: ${state.message}"),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed:
                                    () => context.read<HomeBloc>().add(
                                      LoadCategories(),
                                    ),
                                child: const Text("Retry"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  if (state is HomeLoaded) {
                    final categories = List<CategoryModel>.from(
                      state.categories,
                    )..shuffle();

                    if (categories.isEmpty) {
                      return const SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: 500,
                          child: Center(child: Text("No categories found")),
                        ),
                      );
                    }

                    return CustomScrollView(
                      cacheExtent: 800,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      slivers: [
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: AutoSlidingBanner(),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 20)),
                        SliverList.separated(
                          itemCount: categories.length,
                          separatorBuilder:
                              (_, _) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return _CategorySection(
                              key: ValueKey(category.iD),
                              category: category,
                            );
                          },
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 70)),
                      ],
                    );
                  }

                  return const SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: SizedBox(height: 500),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  final CategoryModel category;
  static const double _itemW = 200.0;
  static const double _sep = 12.0;

  const _CategorySection({super.key, required this.category});

  List<Widget> _buildItems() {
    final products = category.products ?? [];
    return products
        .map((p) => SizedBox(width: _itemW, child: ProductCard(product: p)))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final items = _buildItems();
    if (items.isEmpty) return const SizedBox.shrink();

    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    final title = isEnglish ? category.ename.toUpperCase() : category.arname;

    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CategoryHeader(title: title, category: category),
          SizedBox(
            height: 305,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
                scrollbars: false,
              ),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                separatorBuilder: (_, _) => const SizedBox(width: _sep),
                itemBuilder: (context, i) => items[i],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  final String title;
  final CategoryModel category;

  const _CategoryHeader({required this.title, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.0),
                    AppColors.primary.withOpacity(0.5),
                    AppColors.primary.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => CategoryProductPage(
                          products: category.products ?? [],
                          categoryTitle: title,
                          categoryid: category.iD!,
                        ),
                  ),
                ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.primary.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
