import 'package:flutter/material.dart';
import 'package:progress_soft_app/application_layer/resources/values_manager.dart';
import 'package:shimmer/shimmer.dart';

class PostsShimmerLoading extends StatelessWidget {
  const PostsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final Color firstColor = Colors.grey.shade100;
    final Color secondColor = Colors.grey.shade400;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                5,
                (index) => Padding(
                  padding: const EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p12,
                    right: AppPadding.p12,
                    bottom: AppPadding.p8,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 165,
                    child: Shimmer.fromColors(
                      baseColor: firstColor,
                      highlightColor: secondColor,
                      child: const Card(
                        elevation: 0,
                        margin: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
