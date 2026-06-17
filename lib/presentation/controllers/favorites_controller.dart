import 'package:flutter/foundation.dart';

class FavoritesController extends ChangeNotifier {
  FavoritesController._();

  static final FavoritesController instance = FavoritesController._();

  final Set<int> _favoriteProductIds = <int>{};

  Set<int> get favoriteProductIds => Set.unmodifiable(_favoriteProductIds);

  bool isFavorite(int productId) => _favoriteProductIds.contains(productId);

  void toggleFavorite(int productId) {
    if (!_favoriteProductIds.add(productId)) {
      _favoriteProductIds.remove(productId);
    }

    notifyListeners();
  }

  void removeFavorite(int productId) {
    final removed = _favoriteProductIds.remove(productId);

    if (removed) {
      notifyListeners();
    }
  }
}
