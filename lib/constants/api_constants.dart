class ApiConstants {

  static const String _baseUrl = "http://192.168.1.10:8080/api/v1";

  static const String productsUrl = "$_baseUrl/products";
  static const String productsBatchesUrl = "$_baseUrl/products-batches";
  static const String doneeInstitutionsUrl = "$_baseUrl/donee-institutions";
  static const String supervisoryOrgansUrl = "$_baseUrl/supervisory-organs";

  static const Map<String, String> headers = {
    "Accept": "application/json",
    "Content-type": "application/json"
  };

  static String getBusinessHoursUrl(int? doneeInstitutionId) {
    return "$doneeInstitutionsUrl/$doneeInstitutionId/business-hours";
  }
  
}