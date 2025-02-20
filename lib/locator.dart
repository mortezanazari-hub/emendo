import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/helper/shared_operator.dart';

final locator = GetIt.instance;

Future<void> setUpGetIt () async {

  locator.registerSingleton<SharedPrefOperator>(SharedPrefOperator(await SharedPreferences.getInstance()));

}
