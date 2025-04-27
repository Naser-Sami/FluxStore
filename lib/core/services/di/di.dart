import 'package:get_it/get_it.dart';

import 'init_controllers.dart';
import 'init_data_sources.dart';
import 'init_dio.dart';
import 'init_firebase.dart' show initFirebase;
import 'init_firebase_firestore.dart';
import 'init_firebase_messaging.dart';
import 'init_internet_connection_checker.dart';
import 'init_repositories.dart';
import 'init_secure_storage_service.dart';
import 'init_services.dart';
import 'init_use_cases.dart';

final sl = GetIt.I;

class DI {
  Future<void> init() async {
    await internetConnectionChecker();
    await initDio();
    await initServices();
    await initDataSources();
    await initRepositories();
    await initUseCases();
    await initControllers();
    await initSecureStorageService();
    await initFirebase();
    await initFirebaseFirestore();
    await initFirebaseMessaging();
  }
}
