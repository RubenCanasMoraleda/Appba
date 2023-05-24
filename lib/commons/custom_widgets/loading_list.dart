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
          return item;
        },
      ),
    );
  }
}
