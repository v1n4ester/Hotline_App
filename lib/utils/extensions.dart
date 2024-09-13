import 'package:flutter/material.dart';
import 'package:hotline_app/utils/app_phrases.dart';
import 'package:hotline_app/utils/enums.dart';
import 'package:hotline_app/utils/svg_asset_manager.dart';

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension DoubleExtension on double {
  String get currency => "$this грн";
}

extension ProductCategoryExtension on ProductCategory {
  String get string {
    switch (this) {
      case ProductCategory.all:
        return AppPhrases.allCaption;
      case ProductCategory.isDrink:
        return AppPhrases.drinksCaption;
      case ProductCategory.isFruit:
        return AppPhrases.fruitsCaption;
      case ProductCategory.isVegetable:
        return AppPhrases.vegetablesCaption;
    }
  }
}

extension ProductsSortedByExtension on ProductsSortedBy {
  String get string {
    switch (this) {
      case ProductsSortedBy.priceAsc:
      case ProductsSortedBy.priceDesc:
        return AppPhrases.priceCaption;
      case ProductsSortedBy.ratingAsc:
      case ProductsSortedBy.ratingDesc:
        return AppPhrases.ratingCaption;
      case ProductsSortedBy.none:
        return AppPhrases.noneCaption;
    }
  }

  String? get iconPath {
    switch (this) {
      case ProductsSortedBy.priceAsc:
      case ProductsSortedBy.ratingAsc:
        return SvgAssetManager.ascIcon;
      case ProductsSortedBy.priceDesc:
      case ProductsSortedBy.ratingDesc:
        return SvgAssetManager.descIcon;
      case ProductsSortedBy.none:
        return null;
    }
  }
}
