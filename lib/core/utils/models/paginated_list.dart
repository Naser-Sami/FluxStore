class PaginatedList<T> {
  final List<T> items;
  final int totalCount;

  PaginatedList({required this.items, required this.totalCount});
}
