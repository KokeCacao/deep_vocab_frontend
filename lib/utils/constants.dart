class Constants {
  static const String NAVIGATION_LEARNING_LABEL = "Learn";
  static const String NAVIGATION_EXPLORE_LABEL = "Explore";
  static const String NAVIGATION_STATS_LABEL = "Stats";
  static const String NAVIGATION_USER_LABEL = "Me";

  static const String UPLOAD_MUTATION = r'''
  mutation uploadMutation($uuid: UUID!, $accessToken: String!, $file: Upload!) {
    upload(uuid: $uuid, accessToken: $accessToken, file: $file) {
      ok
    }
  }''';

  /// Request Email Verification Mutation
  static const String REQUEST_EMAIL_VERIFICATION_MUTATION_OPERATION =
      "requestEmailVerificationMutation";
  static const String REQUEST_EMAIL_VERIFICATION_MUTATION_NAME = "createUser";
  static const String REQUEST_EMAIL_VERIFICATION_MUTATION = '''
  mutation $REQUEST_EMAIL_VERIFICATION_MUTATION_OPERATION(\$userName: String!, \$password: String!, \$email: String!) {
    $REQUEST_EMAIL_VERIFICATION_MUTATION_NAME(userName: \$userName, password: \$password, email: \$email) {
      uuid
      accessToken
      refreshToken
    }
  }''';

  /// Create User Mutation
  static const String CREATE_USER_MUTATION_OPERATION = "createUserMutation";
  static const String CREATE_USER_MUTATION_NAME = "createUser";
  static const String CREATE_USER_MUTATION = '''
  mutation $CREATE_USER_MUTATION_OPERATION(\$userName: String!, \$password: String!, \$email: String!, \$emailVerification: String!) {
    $CREATE_USER_MUTATION_NAME(userName: \$userName, password: \$password, email: \$email, emailVerification: \$emailVerification) {
      uuid
      accessToken
      refreshToken
    }
  }''';

  /// Update Query
  static const String UPDATE_QUERY_OPERATION = "updateQuery";
  static const String UPDATE_QUERY_NAME = "update";
  static const String UPDATE_QUERY = '''
  query $UPDATE_QUERY_OPERATION(\$version: String!, \$buildNumber: Int!) {
    $UPDATE_QUERY_NAME(version: \$version, buildNumber: \$buildNumber) {
      latestVersion
      latestBuildNumber
      latestDate
      changeLogs
      shouldUpdate
      breaking
    }
  }''';

  /// Regexp
  // See: http://www.pcre.org/original/doc/html/pcrepattern.html
  static const String REGEXP_USERNAME = r'^[\p{L}\p{M}\p{S}\p{N}\p{P}]{4,64}$';
  static const String REGEXP_EMAIL = r"^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$";
  static const String REGEXP_PASSWORD = r"^(?=.*[A-Za-z!@#%^=+_|\\-])(?=.*\d)[A-Za-z\d!@#%^=+_|\\-]{6,64}$";
  static const String REGEXP_CODE = r'^[0-9]{6}$';
}
