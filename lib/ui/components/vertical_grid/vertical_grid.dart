import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jumpets_app/models/ads/ad.dart';
import 'package:jumpets_app/models/ads/animal_ad.dart';
import 'package:jumpets_app/models/viewmodels/info_card_view_model.dart';

import 'package:jumpets_app/ui/components/cards/animal_card.dart';
import 'package:jumpets_app/ui/components/cards/info_card.dart';
import 'package:jumpets_app/ui/components/cards/other_card.dart';
import 'package:jumpets_app/ui/components/placeholders/custom_content_placeholder.dart';

class VerticalGrid extends StatelessWidget {
  final List<Ad> ads;
  final List<InfoCardViewModel> infoCards;
  final bool usePlaceholders;
  final bool insertPlaceholderAtLast;

  VerticalGrid({
    this.ads,
    this.infoCards,
    this.usePlaceholders = false,
    this.insertPlaceholderAtLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final double height = 210;
    final double padding = 20;

    final list = usePlaceholders
        ? List<Widget>.generate(
            6,
            (index) => ContentPlaceholder(
                  borderRadius: 20,
                  height: height * (index == 0 ? .5 : 1),
                ))
        : List<Widget>.from(ads.map((ad) {
            if (ad is AnimalAd) {
              return AnimalCard(
                animalAd: ad,
                height: height,
              );
            }
            return OtherCard(
              ad: ad,
              height: height - 100,
            );
          }).toList());

    if (!usePlaceholders && (infoCards?.isNotEmpty ?? false)) {
      list.insert(
        0,
        InfoCard(
          title: infoCards.first.title,
          message: infoCards.first.msg,
          url: infoCards.first.url
        ),
      );
    }

    if (insertPlaceholderAtLast) {
      list.add(ContentPlaceholder(
        borderRadius: 20,
        height: height,
      ));
    }

    return Container(
      child: StaggeredGridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding),
          crossAxisSpacing: padding,
          mainAxisSpacing: padding,
          crossAxisCount: 2,
          children: list,
          staggeredTiles: List.generate(list.length, (int index) {
            if (list[index] is InfoCard && (list[index] as InfoCard).big) {
              return StaggeredTile.fit(2);
            } else
              return StaggeredTile.fit(1);
          })),
    );
  }
}
