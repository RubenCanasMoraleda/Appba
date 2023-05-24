import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingList {
  LoadingList._();

  static Widget of(int itemCount, Widget item) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey,
      period: const Duration(milliseconds: 1000),
      child: ListView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: ApbaColors.border1))),
              child: item);
        },
      ),
    );
  }
}
