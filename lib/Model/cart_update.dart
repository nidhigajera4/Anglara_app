class CartUpdate{
  int? id;
  int? userId;
  DateTime? date;
  List<Map<String,dynamic>>? products;

  CartUpdate({this.id, this.userId, this.date, this.products});

  CartUpdate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'];
    products=json['products'];
  }

  Map<String, dynamic> toJson() {
    return{
      'userId':userId,
      'date':date!.toIso8601String(),
      'products':products
    };
   
  }
}

