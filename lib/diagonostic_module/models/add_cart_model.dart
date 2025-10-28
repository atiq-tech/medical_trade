class AddToCartModel {
  String? productId;
  String? name;
  String? code;
  String? categoryId;
  String? categoryName;
  String? salesRate;
  String? purchaseRate;
  String? colorId;
  String? color;
  String? sizeId;
  String? size;
  String? quantity;
  String? vat;
  String? discount;
  String? discountAmount;
  String? total;
  String? note;
  String? isService;
  String? isConvert;
  String? convertQty;
  String? convertName;
  String? unitName;
  String? pcsQty;
  String? unitQty;

  AddToCartModel({
    required this.productId,
    required this.name,
    required this.code,
    required this.categoryId,
    required this.categoryName,
    required this.salesRate,
    required this.purchaseRate,
    required this.colorId,
    required this.color,
    required this.sizeId,
    required this.size,
    required this.quantity,
    required this.discount,
    required this.vat,
    required this.discountAmount,
    required this.total,
    required this.note,
    required this.isService,
    required this.isConvert,
    required this.convertQty,
    required this.convertName,
    required this.unitName,
    required this.pcsQty,
    required this.unitQty,
  });
}