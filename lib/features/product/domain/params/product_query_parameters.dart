class ProductQueryParameters {
  final String? categoryId;
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
    this.minPrice,
    this.maxPrice,
    this.colors,
    this.sizes,
    this.minRating,
    this.hasDiscount,
    this.pageNumber,
    this.pageSize,
    this.sortBy,
    this.sortDescending,
  });

  Map<String, dynamic> toMap() {
    return {
      'CategoryId': categoryId,
      'MinPrice': minPrice,
      'MaxPrice': maxPrice,
      'Colors': colors,
      'Sizes': sizes,
      'MinRating': minRating,
      'HasDiscount': hasDiscount,
      'PageNumber': pageNumber,
      'PageSize': pageSize,
      'SortBy': sortBy,
      'SortDescending': sortDescending,
    };
  }
}
