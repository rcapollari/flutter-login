import 'package:login_form/data/accountrepository.dart';

class Injector {
  factory Injector() => _instance;

  Injector.internal();

  static final Injector _instance = Injector.internal();

  AccountRepository get accountRepository {
    return AccountRepositoryImpl();
  }

  static Injector getInjector() {
    return _instance;
  }
}