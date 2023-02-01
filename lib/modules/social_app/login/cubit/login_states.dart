abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  final String uId;
  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrodState extends SocialLoginStates {
  final String error;

  SocialLoginErrodState(this.error);
}

class SocialLoginChangePasswordState extends SocialLoginStates {}
