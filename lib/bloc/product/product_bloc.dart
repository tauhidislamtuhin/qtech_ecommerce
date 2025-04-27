import 'package:bloc/bloc.dart';
import '../../data/model/product_model.dart';
import '../../data/service/api_service.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiService apiService;

  ProductBloc(this.apiService) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<SearchProducts>(_onSearchProducts);
    on<ShowCount>(_onShowCount);
    on<SortProducts>(_onSort);
  }

  bool _showCount = false;
  List<ProductModel> _allProducts = [];

  Future<void> _onLoadProducts(
      LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final products = await ApiService.AllProducts();
    if (products != null) {
      _allProducts = products; // save locally
      emit(ProductLoaded(products: products, showCount: false));
    } else {
      emit(ProductError("Failed to load products"));
    }
  }

  void _onSearchProducts(
      SearchProducts event, Emitter<ProductState> emit) {
    if (_allProducts.isNotEmpty) {
      final filtered = _allProducts
          .where((p) => p.title.toLowerCase().contains(event.keyword.toLowerCase()))
          .toList();
      emit(ProductLoaded(products: filtered, showCount: true));
    } else {
      emit(ProductError("No products to search"));
    }
  }

  void _onSort(SortProducts event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      List<ProductModel> sorted = List.from(currentState.products); // sort current view

      switch (event.option) {
        case SortOption.highToLow:
          sorted.sort((a, b) => b.price.compareTo(a.price));
          break;
        case SortOption.lowToHigh:
          sorted.sort((a, b) => a.price.compareTo(b.price));
          break;
        case SortOption.rating:
          sorted.sort((a, b) => b.rating.compareTo(a.rating));
          break;
      }

      emit(ProductLoaded(products: sorted, showCount: _showCount));
    }
  }

  void _onShowCount(ShowCount event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      _showCount = true;
      emit(ProductLoaded(products: currentState.products, showCount: true));
    }
  }
}
