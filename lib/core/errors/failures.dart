import 'package:dio/dio.dart';

abstract class Failure {
  final String error;

  const Failure(this.error);
}

class ServerFailure extends Failure {
  ServerFailure(super.error);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
            'Connection timeout. Please check your internet connection.');
      case DioExceptionType.sendTimeout:
        return ServerFailure(
            'Send timeout. Unable to send request. Please try again.');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
            'Receive timeout. Unable to receive data. Please try again.');
      case DioExceptionType.badCertificate:
        return ServerFailure(
            'Bad certificate. Secure connection could not be established.');
      case DioExceptionType.badResponse:
        return ServerFailure.fromDioResponse(
          dioException.response!.statusCode!,
          dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request was canceled.');
      case DioExceptionType.connectionError:
        return ServerFailure(
            'Please check your internet connection and try again.');
      case DioExceptionType.unknown:
        return ServerFailure('Unexpected Error, Please try again.');
      }
  }

  factory ServerFailure.fromDioResponse(int statsCode, dynamic response) {
    switch (statsCode) {
      case 401:
      case 402:
      case 403:
      case 422:
      case 404:
        return ServerFailure(response['message']);
      case 500:
        return ServerFailure('Internal server error, Please try later!');
      default:
        return ServerFailure('Opps there was an error, Please try again!');
    }
  }
}