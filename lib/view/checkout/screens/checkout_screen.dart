import 'package:ecommerce_app/view/checkout/widgets/address_card.dart';
import 'package:ecommerce_app/view/checkout/widgets/order_summary_card.dart';
import 'package:ecommerce_app/view/checkout/widgets/payment_method_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_textstyles.dart';
import '../../order confirmation/screens/order_confirmation_screen.dart';
import '../widgets/checkout_bottom_bar.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
          color: isDark ? Colors.white: Colors.black,
        ),
        title: Text(
          'Checkout',
          style: AppTextStyle.withColor(
            AppTextStyle.h3,
            isDark ? Colors.white: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'Shipping Address'),
            const SizedBox(height: 16),
            const AddressCard(),
            const SizedBox (height: 24),
            _buildSectionTitle(context, 'Payment Method'),
            const SizedBox (height: 16),
            const PaymentMethodCard(),
            const SizedBox (height: 24),
            _buildSectionTitle(context, 'Order Summary'),
            const SizedBox (height: 16),
            const OrderSummaryCard(),
          ],
        ),
      ),
      bottomNavigationBar: CheckoutBottomBar(
        totalAmount: 662.23,
        onPlaceOrder: (){
          //orderNumber would come from backend
          final orderNumber = 'ORD${DateTime.now()..millisecondsSinceEpoch.toString().substring(7)}';
          Get.to(() => OrderConfirmationScreen(
            orderNumber: orderNumber,
            totalAmount: 662.23 ,
          ));
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title){
    return Text(
      title,
      style: AppTextStyle.withColor(
        AppTextStyle.h3,
        Theme.of(context).textTheme.bodyLarge!.color!,
      ),
    );
  }
}
