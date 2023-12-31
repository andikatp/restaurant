import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LottieState extends StatelessWidget {
  const LottieState({
    required this.lottieAsset, required this.text, super.key,
  });
  final String lottieAsset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            lottieAsset,
            height: Sizes.p300.h,
            fit: BoxFit.cover,
          ),
          Gap.h12,
          Center(
            child: Text(
              text,
              style: context.theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
          Gap.h20,
        ],
      ),
    );
  }
}
