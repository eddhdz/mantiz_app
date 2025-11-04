import '../../../data/models/authentication/login_response_model.dart';
import '../../../data/models/user.dart';
import '../../either.dart';
import '../../enums.dart';

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
