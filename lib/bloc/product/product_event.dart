part of 'product_bloc.dart';

abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class SearchProducts extends ProductEvent {
  final String keyword;
  SearchProducts(this.keyword);
}

class SortProducts extends ProductEvent {
  final SortOption option;

  SortProducts(this.option);
}

enum SortOption { highToLow, lowToHigh, rating }

class ShowCount extends ProductEvent {

}