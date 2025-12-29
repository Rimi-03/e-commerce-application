import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    //Listen to changes in the current index
    ever(currentIndex, (index) {
      //Reset filters if navigate other than Shopping Screen
      if (index != 1) {
        final productController = Get.find<ProductController>();
        productController.resetFilters();
      }
    });
  }

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
