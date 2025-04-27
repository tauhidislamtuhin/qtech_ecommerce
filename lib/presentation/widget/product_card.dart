import 'package:flutter/material.dart';
import '../../data/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final discountedPrice =
        (product.price * (1 - product.discountPercentage / 100))
            .toStringAsFixed(0);

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail and Wishlist Icon
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10)),
                        color: Color(0xffD7DAE1)),
                    child: Image.network(
                      product.thumbnail,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: product.id % 2 == 0  //isFavorite messing
                          ? const Icon(
                              Icons.favorite_border,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                    ),
                  ),
                  if (product.stock <= 0) //all product in stock .screen use id just working test
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Out Of Stock',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Text(
                      '\$$discountedPrice',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '\$${product.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${product.discountPercentage.toStringAsFixed(0)}% OFF',
                      style:
                          const TextStyle(color: Colors.orange, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: Row(
                  children: [
                    Container(
                        height: 20,
                        width: 20,
                        color: Colors.orange,
                        child: Icon(Icons.star, color: Colors.white, size: 14)),
                    const SizedBox(width: 4),
                    Text(
                      product.rating.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                    if (product.reviews != null)
                      Text(
                        ' (${product.reviews!.rating})',
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
