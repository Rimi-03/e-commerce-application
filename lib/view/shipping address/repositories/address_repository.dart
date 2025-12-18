import 'package:ecommerce_app/view/shipping%20address/models/address.dart';

class AddressRepository {
  List<Address> getAddresses() {
    return [
      Address(
        id: '1',
        label: 'Home',
        fullAddress: '123 Main St, Springfield, IL 62701',
        city: 'New York',
        state: 'NY',
        zipCode: '62701',
        isDefault: true,
        type: AddressType.home,
      ),
      Address(
        id: '2',
        label: 'Office',
        fullAddress: '456 Corporate Blvd, Metropolis, IL 62960',
        city: 'New York',
        state: 'NY',
        zipCode: '62960',
        type: AddressType.office,
      ),
    ];
  }

  Address? getDefaultAddress() {
    return getAddresses().firstWhere(
      (address) => address.isDefault,
      orElse: () => getAddresses().first,
    );
  }
}
