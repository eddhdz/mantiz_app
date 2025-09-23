import 'package:mantiz/src/data/models/authentication/uuid_session_response_model.dart';

import '../../either.dart';
import '../../enums.dart';
import '../../../data/models/user_model.dart';

abstract class AuthenticationRepository {
  Future<bool> get isSignedIn;
  Future<User?> getUserData();
  Future<Either<SignInFailure, List<SessionModel>>> signIn(
    String userName,
    String password,
  );
}
