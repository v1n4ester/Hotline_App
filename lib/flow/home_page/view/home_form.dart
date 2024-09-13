import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotline_app/api/products_repository/models/product.dart';
import 'package:hotline_app/flow/home_page/bloc/home_bloc.dart';
import 'package:hotline_app/flow/widgets/custom_pagination_widget.dart';
import 'package:hotline_app/flow/widgets/empty_placeholder.dart';
import 'package:hotline_app/utils/app_phrases.dart';
import 'package:hotline_app/utils/colors.dart';
import 'package:hotline_app/utils/enums.dart';
import 'package:hotline_app/utils/extensions.dart';
import 'package:hotline_app/utils/svg_asset_manager.dart';

class HomeForm extends StatelessWidget {
  const HomeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppPhrases.products),
        centerTitle: true,
        actions: const [
          _FilterDropDownButton(),
          SizedBox(width: 20),
          _SortingDropDownButton(),
          SizedBox(width: 16)
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 10),
          child: const _ProductsList(),
        ),
      ),
    );
  }
}

class _FilterDropDownButton extends StatelessWidget {
  const _FilterDropDownButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.currentCategory != current.currentCategory ||
          previous.isInStock != current.isInStock,
      builder: (context, state) {
        const textStyle = TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        );
        const allCategories = ProductCategory.values;
        return PopupMenuButton(
          child: SvgPicture.asset(
            SvgAssetManager.filterIcon,
            color: Colors.black,
            width: 25,
          ),
          itemBuilder: (firstButtonContext) {
            return [
              PopupMenuItem(
                child: PopupMenuButton(
                  itemBuilder: (secondButtonContext) {
                    final List<PopupMenuItem> buttons = List.generate(
                      allCategories.length,
                      (index) {
                        final category = allCategories[index];
                        final bool isActive = category == state.currentCategory;
                        return PopupMenuItem(
                            child: Text(
                              category.string,
                              style: textStyle.copyWith(
                                color: isActive
                                    ? AppColors.textColor
                                    : Colors.white,
                              ),
                            ),
                            onTap: () {
                              context
                                  .read<HomeBloc>()
                                  .add(ChangeCurrentCategory(category));
                              Navigator.of(context).pop();
                            });
                      },
                    );
                    return buttons;
                  },
                  child: const Row(
                    children: [
                      Text(
                        AppPhrases.categoryCaption,
                        style: textStyle,
                      ),
                      Icon(
                        Icons.chevron_right_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                child: PopupMenuButton(
                  itemBuilder: (secondButtonContext) {
                    final isInStock = state.isInStock;
                    return [
                      PopupMenuItem(
                          child: Text(
                            AppPhrases.anyCaption,
                            style: textStyle.copyWith(
                              color: isInStock == null
                                  ? AppColors.textColor
                                  : Colors.white,
                            ),
                          ),
                          onTap: () {
                            context
                                .read<HomeBloc>()
                                .add(const ChangeIsInStock(null));
                            Navigator.of(context).pop();
                          }),
                      PopupMenuItem(
                          child: Text(
                            AppPhrases.inStock,
                            style: textStyle.copyWith(
                              color: isInStock == true
                                  ? AppColors.textColor
                                  : Colors.white,
                            ),
                          ),
                          onTap: () {
                            context
                                .read<HomeBloc>()
                                .add(const ChangeIsInStock(true));
                            Navigator.of(context).pop();
                          }),
                      PopupMenuItem(
                          child: Text(
                            AppPhrases.notAvailable,
                            style: textStyle.copyWith(
                              color: isInStock == false
                                  ? AppColors.textColor
                                  : Colors.white,
                            ),
                          ),
                          onTap: () {
                            context
                                .read<HomeBloc>()
                                .add(const ChangeIsInStock(false));
                            Navigator.of(context).pop();
                          }),
                    ];
                  },
                  child: const Row(
                    children: [
                      Text(
                        AppPhrases.availabilityCaption,
                        style: textStyle,
                      ),
                      Icon(
                        Icons.chevron_right_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ];
          },
        );
      },
    );
  }
}

class _SortingDropDownButton extends StatelessWidget {
  const _SortingDropDownButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.productsSorting != current.productsSorting,
      builder: (context, state) {
        const allSortingValues = ProductsSortedBy.values;
        return PopupMenuButton(
          child: SvgPicture.asset(
            SvgAssetManager.sortingIcon,
            color: Colors.black,
            width: 25,
          ),
          itemBuilder: (context) {
            final List<PopupMenuItem> buttons = List.generate(
              allSortingValues.length,
              (index) {
                final sortingValue = allSortingValues[index];
                final bool isActive = sortingValue == state.productsSorting;
                return PopupMenuItem(
                  child: Row(
                    children: [
                      Text(
                        sortingValue.string,
                        style: TextStyle(
                          color: isActive ? AppColors.textColor : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (sortingValue.iconPath != null)
                        SvgPicture.asset(
                          sortingValue.iconPath!,
                          color: isActive ? AppColors.textColor : Colors.white,
                          height: 15,
                        )
                    ],
                  ),
                  onTap: () => context
                      .read<HomeBloc>()
                      .add(ChangeSortingEvent(sortingValue)),
                );
              },
            );
            return buttons;
          },
        );
      },
    );
  }
}

class _ProductsList extends StatelessWidget {
  const _ProductsList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.sortedProducts != current.sortedProducts,
      builder: (context, state) {
        final products = state.sortedProducts;
        if (products.isEmpty) {
          return EmptyPlaceholder(
            onPressed: () =>
                context.read<HomeBloc>().add(const HomeInitialEvent()),
          );
        }
        return CustomPaginationWidget(
          onLoadMore: () {},
          onRefresh: () {},
          isSeparated: true,
          itemCount: products.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return _ProductCard(product: products[index]);
          },
        );
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textTheme.labelMedium?.copyWith(
      fontSize: 16,
    );
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  product.name.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: textStyle,
                ),
              ),
              const SizedBox(width: 10),
              Text(product.rating.toString(), style: textStyle),
              const SizedBox(width: 8),
              SvgPicture.asset(
                SvgAssetManager.ratingIcon,
                height: 13,
              )
            ],
          ),
          gap,
          Row(
            children: [
              const SizedBox(
                height: 60,
                width: 50,
                child: Placeholder(
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getDescription(
                    field: AppPhrases.categoryCaption,
                    value: product.category.string,
                  ),
                  gap,
                  _getDescription(
                    field: AppPhrases.priceCaption,
                    value: product.price.currency,
                  ),
                ],
              ),
            ],
          ),
          gap,
          Text(
            product.inStock ? AppPhrases.inStock : AppPhrases.notAvailable,
            style: textStyle,
          ),
        ],
      ),
    );
  }

  Widget get gap => const SizedBox(height: 10);

  Widget _getDescription({
    required String field,
    required String value,
  }) =>
      Row(
        children: [
          Text(
            "$field:",
            style: const TextStyle(color: AppColors.textHint),
          ),
          const SizedBox(width: 5),
          Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      );
}
