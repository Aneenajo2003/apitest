class ResponseMain {
  ResponseMain({
    this.products,
  });

  ResponseMain.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = List<Product>.from(json['products'].map((x) => Product.fromJson(x)));
    }
  }

  List<Product>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (products != null) {
      map['products'] = products?.map((x) => x.toJson()).toList();
    }
    return map;
  }
}
class Product {
  Product({
    this.id,
    this.name,
    this.description,
    this.mrp,
    this.distributorPrice,
    this.productId,
  });

  Product.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    mrp = json['mrp'];
    distributorPrice = json['distributor_price'];
    productId = json['product_id'];
  }

  int? id;
  String? name;
  String? description;
  int? mrp;
  String? distributorPrice;
  String? productId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['mrp'] = mrp;
    map['distributor_price'] = distributorPrice;
    map['product_id'] = productId;
    return map;
  }
}
