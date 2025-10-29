import '../../../data/models/authentication/login_response_model.dart';
import '../../either.dart';
import '../../enums.dart';
import '../../../data/models/user_model.dart';

abstract class AuthenticationRepository {
  Future<bool> get isSignedIn;
  Future<User?> getUserData();
  Future<Either<SignInFailure, LoginResponseModel>> signIn(
    String userName,
    String password,
    String mobileUuid,
    String? firebasetoken,
  );
}
