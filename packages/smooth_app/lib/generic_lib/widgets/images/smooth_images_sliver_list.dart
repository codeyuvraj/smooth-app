import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_app/data_models/product_image_data.dart';
import 'package:smooth_app/generic_lib/loading_sliver.dart';
import 'package:smooth_app/generic_lib/widgets/images/smooth_images_view.dart';
import 'package:smooth_app/generic_lib/widgets/smooth_list_tile_card.dart';
import 'package:smooth_app/helpers/product_cards_helper.dart';

/// Displays a [SliverList] by using [SmoothListTileCard] for showing images
/// passed via [imagesData].
///
/// If [loading] is set to `true`, the list shows instead
/// loading [SmoothListTileCard]s.
class SmoothImagesSliverList extends SmoothImagesView {
  const SmoothImagesSliverList({
    required super.imagesData,
    super.onTap,
    super.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);
    final ThemeData themeData = Theme.of(context);
    final List<MapEntry<ProductImageData, ImageProvider?>> imageList =
        imagesData.entries.toList();
    final int count = imageList.length;

    return SliverList(
      delegate: LoadingSliverChildBuilderDelegate(
        loading: loading,
        childCount: count,
        loadingWidget: SmoothListTileCard.loading(),
        childBuilder: (_, int index) => SmoothListTileCard.image(
          imageProvider: imageList[index].value,
          title: Text(
            getProductImageTitle(
              appLocalizations,
              imageList[index].key.imageField,
            ),
            style: themeData.textTheme.headlineMedium,
          ),
          onTap: onTap == null
              ? null
              : () => onTap!(
                    imageList[index].key,
                    imageList[index].value,
                    index,
                  ),
        ),
      ),
    );
  }
}
