enum OrderStatus { notProccessed, processing, shipped, delivered, cancel }

extension OrderStatusValue on OrderStatus {
  String get value {
    switch (this) {
      case OrderStatus.notProccessed:
        return "Not Proccesssed";
      case OrderStatus.processing:
        return "Processing";
      case OrderStatus.shipped:
        return "Shipped";
      case OrderStatus.delivered:
        return "Delivered";
      case OrderStatus.cancel:
        return "Canceled";
    }
  }
}

const Map<String, OrderStatus> orderMap = {
  "Not Process": OrderStatus.notProccessed,
  "Processing": OrderStatus.processing,
  "Shipped": OrderStatus.shipped,
  "Delivered": OrderStatus.delivered,
  "Canceled": OrderStatus.cancel
};

class Order {
  Order({
    required this.id,
    required this.products,
    required this.seller,
    required this.payment,
    required this.buyer,
    required this.totalPrice,
    required this.status,
    required this.deliveryAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final List<ProductElement> products;
  final String seller;
  final String payment;
  final Buyer buyer;
  final int totalPrice;
  final OrderStatus status;
  final String deliveryAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["_id"],
        products: List<ProductElement>.from(
            json["products"].map((x) => ProductElement.fromJson(x))),
        seller: json["seller"],
        payment: json["payment"],
        buyer: Buyer.fromJson(json["buyer"]),
        totalPrice: json["totalPrice"],
        status:
            orderMap[json["status"].toString()] ?? OrderStatus.notProccessed,
        deliveryAddress: json["deliveryAddress"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "seller": seller,
        "payment": payment,
        "buyer": buyer.toJson(),
        "totalPrice": totalPrice,
        "status": status,
        "deliveryAddress": deliveryAddress,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Buyer {
  Buyer({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String name;
  final String email;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class ProductElement {
  ProductElement({
    required this.product,
    required this.quantity,
    required this.id,
  });

  final ProductProduct product;
  final int quantity;
  final String id;

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        product: ProductProduct.fromJson(json["product"]),
        quantity: json["quantity"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "quantity": quantity,
        "_id": id,
      };
}

class ProductProduct {
  ProductProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.brand,
    required this.images,
    required this.thumbnail,
    required this.price,
    required this.countInStock,
    required this.rating,
    required this.numReviews,
    required this.seller,
    required this.feature,
    required this.reviews,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String name;
  final String description;
  final String category;
  final String brand;
  final List<Thumbnail> images;
  final Thumbnail thumbnail;
  final int price;
  final int countInStock;
  final int rating;
  final int numReviews;
  final String seller;
  final String feature;
  final List<dynamic> reviews;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        category: json["category"],
        brand: json["brand"],
        images: List<Thumbnail>.from(
            json["images"].map((x) => Thumbnail.fromJson(x))),
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        price: json["price"],
        countInStock: json["countInStock"],
        rating: json["rating"],
        numReviews: json["numReviews"],
        seller: json["seller"],
        feature: json["feature"],
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "category": category,
        "brand": brand,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "thumbnail": thumbnail.toJson(),
        "price": price,
        "countInStock": countInStock,
        "rating": rating,
        "numReviews": numReviews,
        "seller": seller,
        "feature": feature,
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Thumbnail {
  Thumbnail({
    required this.url,
    required this.publicId,
  });

  final String url;
  final String publicId;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        url: json["url"],
        publicId: json["publicId"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "publicId": publicId,
      };
}
