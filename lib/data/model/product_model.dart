class ProductModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final String thumbnail;
  final double price;
  final double discountPercentage;
  final double rating;
  final double stock;
  final Review? reviews;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    this.reviews,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> reviewList = json['reviews'] ?? [];

    return ProductModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      stock: (json['stock'] as num).toDouble(),
      reviews: reviewList.isNotEmpty
          ? Review.fromJson(reviewList.first as Map<String, dynamic>)
          : null,
    );
  }
}

class Review {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'],
      comment: json['comment'],
      date: json['date'],
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
    );
  }
}
