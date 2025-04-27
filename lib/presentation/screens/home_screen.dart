import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtech_ecommerce/presentation/widget/custom_search_bar.dart';
import '../../bloc/product/product_bloc.dart';
import '../../data/service/api_service.dart';
import '../widget/product_card.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductBloc(ApiService())..add(LoadProducts()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 40,bottom:10, left: 10,right: 10),
          child: Column(
            children: [
              const CustomSearchBar(),
              SizedBox(height: 10,),
              Expanded(
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ProductError) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else if (state is ProductLoaded) {
                      final products = state.products;

                      if (products.isEmpty) {
                        return const Center(child: Text('No products found'));
                      }

                      return GridView.builder(
                        itemCount: products.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(product: product);
                        },
                      );
                    } else {
                      return const SizedBox(); // For ProductInitial
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
