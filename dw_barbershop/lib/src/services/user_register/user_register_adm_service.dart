import '../../core/exceptions/service_exception.dart';
import '../../core/fp/either.dart';
import '../../core/fp/nil.dart';

abstract interface class UserRegisterAdmService {
  Future<Either<ServiceException, Nil>> execute(
    ({String name, String email, String password}) userData,
  );
}
