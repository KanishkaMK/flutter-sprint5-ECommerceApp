class Product {
  Product({
    required this.productName,
    required this.productCode,
    required this.price,
    required this.description,
    required this.stock,
    required this.imageurl,
  });

  Product.fromJson(Map<String, dynamic> json) {
    productName = json['name'].toString();
    productCode = json['code'].toString();
    price = double.parse(json['price'].toString());
    description = json['description'].toString();
    stock = int.parse(json['stock'].toString());
    imageurl = json['image'].toString();
  }
  
  late final String productName;
  late final String productCode;
  late final double price;
  late final String description;  
  late final int stock;
  late final String imageurl;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    
    _data['name'] = productName;
    _data['code'] = productCode;    
    _data['price'] = price;
    _data['description'] = description;
    _data['stock'] = stock;
    _data['image'] = imageurl;
    return _data;
  }
}
