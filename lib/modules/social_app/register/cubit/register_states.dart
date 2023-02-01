abstract class SocialAppRegisterStates {}

class SocialRegisterInitialState extends SocialAppRegisterStates {}

class SocialRegisterLoadingState extends SocialAppRegisterStates {}

class SocialRegisterSuccessState extends SocialAppRegisterStates {}

class SocialRegisterErrorState extends SocialAppRegisterStates {

  final String error;

  SocialRegisterErrorState(this.error);

}

class SocialCreateUserSuccessState extends SocialAppRegisterStates {}

class SocialCreateUserErrorState extends SocialAppRegisterStates {

  final String error;

  SocialCreateUserErrorState(this.error);

}

class SocialRegisterChangePasswordState extends SocialAppRegisterStates {}
