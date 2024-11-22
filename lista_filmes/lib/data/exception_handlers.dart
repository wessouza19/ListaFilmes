import 'package:dio/dio.dart';

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r, Response? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    if (response != null) {
      return response!.data['error'].value.first[0];
    }

    return 'Requisição Invalida';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Ocorreu um erro interno, favor tente novamente mais tarde';
  }
}
