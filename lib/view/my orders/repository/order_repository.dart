import 'package:ecommerce_app/view/my%20orders/model/order.dart';

class OrderRepository {
  List<Order> getOrders() {
    return [
      Order(
        orderNumber: '123432',
        itemCount: 3,
        totalAmount: 2938.3,
        status: OrderStatus.active,
        imageUrl: 'e-commerce-application/assets/images/shoe.jpg',
        orderDate: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Order(
        orderNumber: '923457',
        itemCount: 1,
        totalAmount: 50.00,
        status: OrderStatus.completed,
        imageUrl: 'e-commerce-application/assets/images/laptop.jpg',
        orderDate: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      Order(
        orderNumber: '173432',
        itemCount: 2,
        totalAmount: 2938.3,
        status: OrderStatus.active,
        imageUrl: 'e-commerce-application/assets/images/shoe2.jpg',
        orderDate: DateTime.now().subtract(const Duration(hours: 7)),
      ),
      Order(
        orderNumber: '703458',
        itemCount: 4,
        totalAmount: 80.25,
        status: OrderStatus.cancelled,
        imageUrl: 'e-commerce-application/assets/images/shoes2.jpg',
        orderDate: DateTime.now().subtract(const Duration(hours: 3)),
      ),
    ];
  }

  List<Order> getOrderByStatus(OrderStatus status) {
    return getOrders().where((order) => order.status == status).toList();
  }
}