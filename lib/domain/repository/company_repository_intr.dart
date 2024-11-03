import 'dart:io';

import 'package:agenda_electronica/domain/request/company_request.dart';
import 'package:http/http.dart';

abstract class CompanyRepositoryInterface {
  Future<Response> createCompany(CompanyRequest company);
  Future<void> updateCompany(CompanyRequest company);
  Future<Response> getQuotesToCompany(int companyId);
  Future<File> getPdf(int quoteId);
}
