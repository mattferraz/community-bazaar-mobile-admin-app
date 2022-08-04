class ApiConstants {
  static const String _baseUrl = "http://localhost:8080/api/v1";

  static const String productsUrl = "$_baseUrl/products";
  static const String productsBatchesUrl = "$_baseUrl/products-batches";
  static const String doneeInstitutionsUrl = "$_baseUrl/donee-instutitions";
  static const String supervisoryOrgansUrl = "$_baseUrl/supervisory-organs";

  static const Map<String, String> headers = {
    "Accept": "application/json",
    "Content-type": "application/json"
  };

  static String businessHoursUrl(int doneeInstitutionId) {
    return "$doneeInstitutionsUrl/$doneeInstitutionId/business-hours";
  }
}