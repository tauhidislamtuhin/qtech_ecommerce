part of 'product_bloc.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final bool showCount;

  ProductLoaded({required this.products, this.showCount = false});

  ProductLoaded copyWith({List<ProductModel>? products, bool? showCount}) {
    return ProductLoaded(
      products: products ?? this.products,
      showCount: showCount ?? this.showCount,
    );
  }
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}