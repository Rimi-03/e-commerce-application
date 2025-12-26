import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/product_firebase_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final RxList<Product> _allProducts = <Product>[].obs;
  final RxList<Product> _filteredProducts = <Product>[].obs;
  final RxList<Product> _featuredProducts = <Product>[].obs;
  final RxList<Product> _saleProducts = <Product>[].obs;
  final RxList<String> _categories = <String>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _hasError = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxString _selectedCategory = 'All'.obs;
  final RxString _searchQuery = ''.obs;

  //getters
  List<Product> get allProducts => _allProducts;
  List<Product> get filteredProducts => _filteredProducts;
  List<Product> get featuredProducts => _featuredProducts;
  List<Product> get saleProducts => _saleProducts;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading.value;
  bool get hasError => _hasError.value;
  String get errorMessage => _errorMessage.value;
  String get selectedCategory => _selectedCategory.value;
  String get searchQuery => _searchQuery.value;

  @override
  void onInit() {
    super.onInit();
    _selectedCategory.value = 'All'; //initialize with 'All' selected
    loadProducts();
  }

  //Load all products from firestore
  Future<void> loadProducts() async {
    _isLoading.value = true;
    _hasError.value = false;

    try {
      final products = await ProductFirebaseService.getAllProducts();
      //Set products from firestore
      _allProducts.value = products;
      _filteredProducts.value = products;

      //Load other product lists
      await _loadFeaturedProducts();
      await _loadSaleProducts();
      await _loadCategories();
    } catch (e) {
      _hasError.value = true;
      _errorMessage.value = 'Failed to load products. Please try again.';
      print('Error loading products. $e');

      //Clear products on error
      _allProducts.value = [];
      _filteredProducts.value = [];
    } finally {
      _isLoading.value = false;
    }
  }

  //Load featured products
  Future<void> _loadFeaturedProducts() async {
    try {
      final featured = await ProductFirebaseService.getFeaturedProducts();
      _featuredProducts.value = featured;
    } catch (e) {
      print('Error loading featured products $e');
    }
  }

  //Load sale products
  Future<void> _loadSaleProducts() async {
    try {
      final sale = await ProductFirebaseService.getSaleProducts();
      _saleProducts.value = sale;
    } catch (e) {
      print('Error loading sale products $e');
    }
  }

  //Load categories
  Future<void> _loadCategories() async {
    try {
      final categories = await ProductFirebaseService.getAllCategories();
      _categories.value = categories;
    } catch (e) {
      print('Error loading categories $e');
    }
  }

  //Filter products by category
  void filterByCategory(String category) {
    _selectedCategory.value = category;
    _applyFilters();
    update(); //Notify GetBuilder widgets
  }

  //Search products
  void searchProducts(String query) {
    _searchQuery.value = query;
    _applyFilters();
    update(); //Notify GetBuilder widgets
  }

  //Reset all filters
  void resetFilters() {
    _selectedCategory.value = 'All';
    _searchQuery.value = '';
    _filteredProducts.value = _allProducts;
    update(); //Notify GetBuilder widgets
  }

  //Clear search
  void clearSearch() {
    _searchQuery.value = '';
    _applyFilters();
    update(); //Notify GetBuilder widgets
  }

  //Apply Filters and search
  void _applyFilters() {
    List<Product> filtered = List.from(_allProducts);

    //apply category filter
    if (_selectedCategory.value != 'All' &&
        _selectedCategory.value.isNotEmpty) {
      final selectedCat = _selectedCategory.value.toLowerCase();
      filtered = filtered.where((product) {
        final productCat = product.category.toLowerCase();

        //Handle special category nappings
        if (selectedCat == 'home & living' || selectedCat == 'home') {
          return productCat == 'home' || productCat == 'home & living';
        }
        if (selectedCat == 'sports & fitness' || selectedCat == 'sports') {
          return productCat == 'sports' || productCat == 'sports & fitness';
        }

        //Match exact category name or display name
        return productCat == selectedCat ||
            productCat.contains(selectedCat) ||
            selectedCat.contains(productCat);
      }).toList();

      print('Filtering by category: ${_selectedCategory.value}');
      print('Found ${filtered.length} products in category');
      print(
        'Available categories in products: ${_allProducts.map((p) => p.category).toSet()}',
      );
    } else {
      print('Showing all products: ${_allProducts.length}');
    }

    //Apply search filter
    if (_searchQuery.value.isNotEmpty) {
        final query = _searchQuery.value.toLowerCase();
        filtered = filtered
            .where((product) =>
                product.name.toLowerCase().contains(query) ||
                product.category.toLowerCase().contains(query) ||
                product.description.toLowerCase().contains(query) ||
                (product.brand?.toLowerCase().contains(query)?? false))
            .toList();
    }
    _filteredProducts.value = filtered;
    print('Total filtered products: ${_filteredProducts.length}');
  }

  //Get products by category
  Future<List<Product>> getProductByCategory(String category) async {
    try{
        return await ProductFirebaseService.getProductByCategory(category);
    } catch(e) {
        print('Error getting products by category: $e');
        return [];
    }
  }

  //Search products in firestore
  Future<List<Product>> searchProductsInFirestore(String searchTerm) async {
    try{
        return await ProductFirebaseService.searchProducts(searchTerm);
    } catch(e) {
        print('Error searching products: $e');
        return [];
    }
  }

  //Get products by ID
  Future<Product?> getProductById(String productId) async {
    try{
        return await ProductFirebaseService.getProductById(productId);
    } catch(e) {
        print('Error getting products by ID: $e');
        return null;
    }
  }

  //Refresh products
  Future<void> refreshProducts() async {
    await loadProducts();
  }

  //clear filters
  void clearFilters(){
    _selectedCategory.value = 'All';
    _searchQuery.value = '';
    _filteredProducts.value = _allProducts;
  }

  //Get products for display
  List<Product> getDisplayProducts() {
    //if 'All' is selected, show all products
    if(_selectedCategory.value == 'All'){
        return _allProducts;
    }
    //otherwise, show filtered products
    return _filteredProducts;
  }
}
