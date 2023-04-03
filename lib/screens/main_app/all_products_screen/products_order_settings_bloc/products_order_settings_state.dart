part of 'products_order_settings_bloc.dart';

enum SortType { priceLow, priceHigh, popular, newProduct }

class ProductsOrderSettingsState {
  final List<Color> filterColors;
  final SortType sortFilter;

  ProductsOrderSettingsState(
      {this.filterColors = const [], this.sortFilter = SortType.popular});

  ProductsOrderSettingsState copyWith(
      {SortType? sortFilter, List<Color>? filterColors}) {
    return ProductsOrderSettingsState(
      filterColors: filterColors ?? this.filterColors,
      sortFilter: sortFilter ?? this.sortFilter,
    );
  }
}
