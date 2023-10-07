import 'package:cloud_firestore/cloud_firestore.dart';
class UpdateOrderRepo{
Future<void> updateOrder(String newStatus,int quantity,double subTotal) async {
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');

  try {
    await orders.doc(orders.id).update({
      'status': newStatus,
      'subtotal':subTotal,
      'quantity':quantity,
    });
  } catch (e) {
    print('Error updating order status: $e');
  }
}
}