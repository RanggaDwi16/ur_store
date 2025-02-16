import 'core/domain/usecases/is_logged_in_test.dart' as is_logged_in_test;
import 'core/domain/usecases/login_test.dart' as login_test;
import 'core/domain/usecases/logout_test.dart' as logout_test;

import 'presentation/home/bloc/all_products_cubit_test.dart'
    as all_products_cubit_test;
import 'presentation/home/bloc/cart_cubit_test.dart' as cart_cubit_test;
import 'presentation/home/bloc/product_cubit_test.dart' as product_cubit_test;

import 'presentation/home/domain/usecase/get_all_product_test.dart'
    as get_all_product_test;
import 'presentation/home/domain/usecase/get_product_test.dart'
    as get_product_test;

import 'presentation/home/pages/detail_product_page_test.dart'
    as detail_product_page_test;
import 'presentation/home/pages/home_page_test.dart' as home_page_test;
import 'services_locator_test.dart' as services_locator_test;

void main() {
  is_logged_in_test.main();
  login_test.main();
  logout_test.main();

  all_products_cubit_test.main();
  cart_cubit_test.main();
  product_cubit_test.main();

  get_all_product_test.main();
  get_product_test.main();

  detail_product_page_test.main();
  home_page_test.main();
  // services_locator_test.main();
}
