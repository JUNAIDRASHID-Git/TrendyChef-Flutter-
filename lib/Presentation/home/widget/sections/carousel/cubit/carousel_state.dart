part of 'carousel_cubit.dart';

class BannerSliderState {
  final List<BannerModel> banners;
  final int currentPage;
  final bool isLoading;

  BannerSliderState({
    required this.banners,
    required this.currentPage,
    this.isLoading = false,
  });

  BannerSliderState copyWith({
    List<BannerModel>? banners,
    int? currentPage,
    bool? isLoading,
  }) {
    return BannerSliderState(
      banners: banners ?? this.banners,
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
