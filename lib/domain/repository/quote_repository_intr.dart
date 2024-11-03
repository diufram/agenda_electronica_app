import 'dart:io';

import 'package:agenda_electronica/domain/request/quote_request.dart';
import 'package:http/http.dart';

abstract class QuoteRepositoryInterface {
  Future<Response> createQuote(
      List<QuoteRequest> quotes, double total, int companyId, double discount);
  Future<void> deleteQuote();
  Future<File> getPdf(int quoteId);
}
