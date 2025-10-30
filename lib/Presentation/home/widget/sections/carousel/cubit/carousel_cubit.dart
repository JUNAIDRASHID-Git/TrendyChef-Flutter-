import 'dart:async' show Timer;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:trendychef/core/services/api/banner/get.dart';
import 'package:trendychef/core/services/models/banner.dart';

part 'carousel_state.dart';

class BannerSliderCubit extends Cubit<BannerSliderState> {
  Timer? _timer;
  final PageController controller = PageController(
    viewportFraction: 0.9,
    initialPage: 1,
  );

  BannerSliderCubit()
    : super(BannerSliderState(banners: [], currentPage: 1, isLoading: true));

  Future<void> loadBanners() async {
    try {
      emit(state.copyWith(isLoading: true));
      final banners = await fetchBanner();

      if (banners.length >= 2) {
        final looped = [banners.last, ...banners, banners.first];
        emit(
          BannerSliderState(banners: looped, currentPage: 1, isLoading: false),
        );
        _startAutoSlide();
      } else {
        emit(
          BannerSliderState(banners: banners, currentPage: 0, isLoading: false),
        );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _startAutoSlide() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (controller.hasClients) {
        final nextPage = controller.page!.round() + 1;
        controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void updatePage(int index) {
    emit(state.copyWith(currentPage: index));
  }

  void dispose() {
    _timer?.cancel();
    controller.dispose();
  }
}
