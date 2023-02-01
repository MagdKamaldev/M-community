abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialChangeAppModeState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;
  SocialGetUserErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error;
  SocialGetAllUsersErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUpdateUserDataLoadingState extends SocialStates {}

class SocialUpdateUserDataErrorState extends SocialStates {}

//create post

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialCreatePostSuccesState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

//get post

class SocialGetPostLoadingState extends SocialStates {}

class SocialGetPostSuccessState extends SocialStates {}

class SocialGetPostErrorState extends SocialStates {
  final String error;
  SocialGetPostErrorState(this.error);
}

//like Post

class SocialLikePostLoadingState extends SocialStates {}

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;
  SocialLikePostErrorState(this.error);
}

//delete Post 

class SocialDeletePostLoadingState extends SocialStates {}

class SocialDeletePostSuccessState extends SocialStates {}

class SocialDeletePostErrorState extends SocialStates {}

//comment
class SocialCommentOnPostLoadingState extends SocialStates {}

class SocialCommentOnPostSuccessState extends SocialStates {}

class SocialCommentOnPostErrorState extends SocialStates {
  final String error;
  SocialCommentOnPostErrorState(this.error);
}
//chat

class SocialSendMessegeSuccessState extends SocialStates {}

class SocialSendMessegeErrorState extends SocialStates {}

class SocialGetMessegeSuccessState extends SocialStates {}

class SocialGetMessegeErrorState extends SocialStates {}

//get Single Post 

class SocialGetsinglePostLoadingState extends SocialStates {}

class SocialGetSinglepostLikesSuccessState extends SocialStates {}

class SocialGetSinglepostCommentsSuccessState extends SocialStates {}

class SocialGetsinglePostSuccessState extends SocialStates {}

class SocialGetsinglePostErrorState extends SocialStates{} 
 

//get comments

class SocialGetPostCommentsLoadingState  extends SocialStates{}

class SocialGetPostCommentsSuccessState extends SocialStates{}

class SocialGetPostCommentsErrorState  extends SocialStates{}

//go to chats 

class SocialGoToChats extends SocialStates{}