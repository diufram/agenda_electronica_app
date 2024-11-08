import 'package:agenda_electronica/domain/response/login_response.dart';

abstract class LocalRepositoryInterface {
  Future<void> saveUser(LoginResponse user);
  Future<int> getUser();
  //Future<String> getToken();
  //Future<void> clearAllData();
  //Future<void> saveUser(User user);
  //Future<String> saveToken(String token);
  //Future<User> getUser();
  //Future<void> saveCompany(Company company);
  //Future<Company> getCompany();
  //Future<void> saveCompanyId(int companyId);
  //Future<int> getCompanyId();
}
