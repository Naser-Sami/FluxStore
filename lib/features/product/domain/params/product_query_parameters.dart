class ProductQueryParameters {
  final String? categoryId;
  final String? search;
  final double? minPrice;
  final double? maxPrice;
  final List<String>? colors;
  final List<String>? sizes;
  final double? minRating;
  final bool? hasDiscount;
  final int? pageNumber;
  final int? pageSize;
  final String? sortBy;
  final bool? sortDescending;

  ProductQueryParameters({
    this.categoryId,
    this.search,
    this.minPrice,
    this.maxPrice,
    this.colors,
    this.sizes,
    this.minRating,
    this.hasDiscount,
    this.pageNumber = 1,
    this.pageSize = 10,
    this.sortBy,
    this.sortDescending,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    if (categoryId != null) map['CategoryId'] = categoryId;
    if (search != null) map['Search'] = search;
    if (minPrice != null) map['MinPrice'] = minPrice;
    if (maxPrice != null) map['MaxPrice'] = maxPrice;
    if (colors != null && colors!.isNotEmpty) map['Colors'] = colors;
    if (sizes != null && sizes!.isNotEmpty) map['Sizes'] = sizes;
    if (minRating != null) map['MinRating'] = minRating;
    if (hasDiscount != null) map['HasDiscount'] = hasDiscount;
    if (pageNumber != null) map['PageNumber'] = pageNumber;
    if (pageSize != null) map['PageSize'] = pageSize;
    if (sortBy != null) map['SortBy'] = sortBy;
    if (sortDescending != null) map['SortDescending'] = sortDescending;

    return map;
  }
}
