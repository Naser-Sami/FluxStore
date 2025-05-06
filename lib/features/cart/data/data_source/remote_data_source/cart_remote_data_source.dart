import '/core/_core.dart' show ApiClient, ApiEndpoints, sl;
import '/features/_features.dart'
    show AddToCartParams, CartModel, RemoveFromCartParams, UpdateCartParams;

abstract class ICartRemoteDataSource {
  Future<void> addToCart(AddToCartParams params);
  Future<void> removeFromCart(RemoveFromCartParams params);
  Future<void> updateCart(UpdateCartParams params);
  Future<CartModel> getCart(String userId);
}

class CartRemoteDataSource extends ICartRemoteDataSource {
  final ApiClient apiClient = sl<ApiClient>();

  @override
  Future<void> addToCart(AddToCartParams params) async {
    try {
      await apiClient.post(path: ApiEndpoints.addCart, data: params.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeFromCart(RemoveFromCartParams params) async {
    try {
      await apiClient.delete(
        path: ApiEndpoints.removeCart,
        data: params.toMap(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateCart(UpdateCartParams params) async {
    try {
      await apiClient.put(path: ApiEndpoints.updateCart, data: params.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CartModel> getCart(String userId) async {
    try {
      parser(data) => CartModel.fromJson(data);

      final response = await apiClient.get<CartModel>(
        path: '${ApiEndpoints.cart}/$userId',
        parser: parser,
      );

      if (response == null) {
        throw Exception('Failed to get cart');
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
