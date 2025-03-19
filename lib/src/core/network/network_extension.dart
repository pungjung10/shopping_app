import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:shopping_app/src/core/base/failure.dart';

class NetworkExtension {
  static const String statusSuccess1000 = "1000";

  static Future<Either<Failure, T>> call<T>({
    required Future<HttpResponse<T>> Function() onCall,
    required Either<Failure, T> Function(T) onSuccess,
    required Either<Failure, T> Function(Failure) onFailure,
    Either<Failure, T> Function()? onSuccessWithEmpty,
  }) async {
    try {
      final response = await onCall();

      if (response.data != null) {
        return onSuccess(response.data);
      } else {
        if (response.response.statusCode == 200 || response.response.statusCode == 204) {
          return onSuccess(response.data);
        } else {
          return onFailure(Failure(errorMessage: response.response.statusMessage.toString()));
        }
      }
    } on DioException catch (e) {
      return onFailure(Failure(errorMessage: e.message.toString()));
    } on Exception catch (e) {
      return onFailure(Failure(errorMessage: e.toString()));
    }
  }
}
