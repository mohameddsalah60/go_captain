import 'package:dio/dio.dart';

class DioExceptionHandler {
  static String handleException(DioException e) {
    String errorMessage;

    if (e.response != null) {
      switch (e.response?.statusCode) {
        case 400:
          errorMessage = "Bad request. Please check your input.";

          break;
        case 401:
          errorMessage = "Unauthorized access. Please check your credentials.";
          break;
        case 403:
          errorMessage =
              "Forbidden access. You do not have permission to view this resource.";
          break;
        case 404:
          errorMessage =
              "Resource not found. Please check the URL or try again later.";
          break;
        case 500:
          errorMessage = "Internal server error. Please try again later.";
          break;
        default:
          errorMessage =
              "An unexpected error occurred: Status code ${e.response?.statusCode}.";
      }
    } else {
      // Handle DioExceptionType cases
      switch (e.type) {
        case DioExceptionType.connectionError:
          errorMessage =
              'There was a connection error. Please check your internet connection and try again.';
        case DioExceptionType.cancel:
          errorMessage = "The request was cancelled. Please try again.";
          break;
        case DioExceptionType.connectionTimeout:
          errorMessage = "Please check your internet connection and try again.";
          break;
        case DioExceptionType.receiveTimeout:
          errorMessage = "Received timeout from the server. Please try again.";
          break;
        case DioExceptionType.sendTimeout:
          errorMessage =
              "Send timeout while connecting to the server. Please try again.";
          break;
        case DioExceptionType.unknown:
          errorMessage =
              "An unknown error occurred: ${e.message}. Please try again.";
          break;
        default:
          errorMessage = "An unspecified error occurred. Please try again.";
      }
    }

    return errorMessage;
  }
}
