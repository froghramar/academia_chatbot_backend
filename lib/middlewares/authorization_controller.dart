import 'package:aqueduct/aqueduct.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

import '../application_configuration.dart';

class AuthorizationController extends Controller {

	@override
	Future<RequestOrResponse> handle(Request request) async {

		try {
			final requestHeaders = request.raw.headers;
			final authorizationToken = requestHeaders.value('Authorization');

			if (authorizationToken != null) {
				final config = ApplicationConfiguration.getInstance();
				final JwtClaim decClaimSet = verifyJwtHS256Signature(authorizationToken, config.jwt['secret']);
				decClaimSet.validate(
					issuer: config.jwt['issuer'],
					audience: requestHeaders.value('user-agent'),
				);
				return request;
			} else {
				return Response.unauthorized();
			}
		} catch (exception) {
			return Response.serverError();
		}
	}
}
