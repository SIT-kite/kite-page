import '../dao/index.dart';

class JwtStorage implements JwtDao {
  @override
  String? jwtToken;
}
