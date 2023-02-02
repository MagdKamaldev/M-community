// ignore_for_file: avoid_print, prefer_const_constructors, deprecated_member_use, invalid_return_type_for_catch_error
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_course/layout/social_app/cubit/social_states.dart';
import 'package:udemy_course/models/social_app/post_model.dart';
import 'package:udemy_course/models/social_app/social_user_model.dart';
import 'package:udemy_course/modules/social_app/profile/profile_screen.dart';
import 'package:udemy_course/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../models/social_app/comment_model.dart';
import '../../../models/social_app/messege_model.dart';
import '../../../modules/Social_app/chats/chats_screen.dart';
import '../../../modules/Social_app/feeds/feeds_screen.dart';
import '../../../shared/networks/local/cache_helper.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection("users").doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    PorfileScreen(),
  ];
  List<String> titles = [
    "Home",
    "Chats",
    "profile",
  ];

  void changeBottomNavBar(int index) {
    if (index == 0) {
      getPosts();
    }
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      getSingleUserPosts();
    }

    currentIndex = index;
    emit(SocialChangeBottomNavState());
  }

  void gotoChats() {
    currentIndex = 1;
    getUsers();
    emit(SocialGoToChats());
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print("no image selected");
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, cover: value);
        //emit(SocialUploadCoverImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      uId: userModel!.uId,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUpdateUserDataErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print("no image selected");
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postimage: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postimage,
  }) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postimage ?? "",
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccesState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];

  getPosts() {
    posts = [];
    FirebaseFirestore.instance.collection("posts").get().then((value) {
      for (var element in value.docs) {
        element.reference.collection("likes").get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialGetPostSuccessState());
        }).catchError((error) {});
      }
    }).catchError((error) {
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  List<PostModel> userPosts = [];
  void getSingleUserPosts() {
    userPosts = [];
    emit(SocialGetSingleUserPostLoadingState());
    FirebaseFirestore.instance.collection("posts").get().then((value) {
      for (var element in value.docs) {
        element.reference.collection("likes").get().then((value) {
          if (PostModel.fromJson(element.data()).uId ==
              FirebaseAuth.instance.currentUser!.uid) {
            userPosts.add(PostModel.fromJson(element.data()));
            emit(SocialGetSingleUserPostSuccessState());
          }
        }).catchError((error) {});
      }
    }).catchError((error) {
      emit(SocialGetSingleUserPostErrorState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(userModel!.uId)
        .set({"like": true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection("users").get().then((value) {
        for (var element in value.docs) {
          if (element.data()["uId"] != userModel!.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        }
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

  void sendMessege({
    required String recieverId,
    required String dateTime,
    required String text,
  }) {
    MessegeModel model = MessegeModel(
      text: text,
      senderId: userModel!.uId,
      recieverId: recieverId,
      dateTime: dateTime,
    );

    //sender
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("chats")
        .doc(recieverId)
        .collection("messeges")
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessegeSuccessState());
    }).catchError((error) {
      emit(SocialSendMessegeErrorState());
    });
    //reciever
    FirebaseFirestore.instance
        .collection("users")
        .doc(recieverId)
        .collection("chats")
        .doc(userModel!.uId)
        .collection("messeges")
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessegeSuccessState());
    }).catchError((error) {
      emit(SocialSendMessegeErrorState());
    });
  }

  List<MessegeModel> messeges = [];

  void getMesseges({
    required String recieverId,
  }) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("chats")
        .doc(recieverId)
        .collection("messeges")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      messeges = [];
      for (var element in event.docs) {
        messeges.add(MessegeModel.fromJson(element.data()));
      }
      emit(SocialGetMessegeSuccessState());
    });
  }

  Map<String, int> postsLikesbymap = ({});
  Map<String, int> postsCommentsbymap = ({});
  List<String> postsId = [];

  void getSinglePost(String posid) {
    emit(SocialGetsinglePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(posid)
        .get()
        .then((value) {
      value.reference.collection('Likes').get().then((value) {
        postsLikesbymap[posid] = value.docs.length;
        emit(SocialGetSinglepostLikesSuccessState());
      }).catchError(onError);
      value.reference.collection('comments').get().then((value) {
        postsCommentsbymap[posid] = value.docs.length;
        emit(SocialGetSinglepostCommentsSuccessState());
      }).catchError(onError);
      emit(SocialGetsinglePostSuccessState());
    }).catchError((e) {
      emit(SocialGetsinglePostErrorState());
      print(e.toString());
    });
  }

  void comment(
      {required String postid,
      required String name,
      required String userImage,
      required String userId,
      required String text,
      required String dateTime}) {
    CommentModel model = CommentModel(
      text: text,
      dateTime: dateTime,
      postid: postid,
      userId: userId,
      userImage: userModel!.image!,
      name: name,
    );
    emit(SocialCommentOnPostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      print('the comment id is ${value.id}');
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postid)
          .collection('comments')
          .doc(value.id)
          .update({'commentId': value.id})
          .then((_) {})
          .catchError((error) {});

      emit(SocialCommentOnPostSuccessState());
      getSinglePost(postid);
    }).catchError((error) {
      emit(SocialCommentOnPostErrorState(error));
      print(error.toString());
    });
  }

  List<CommentModel> postComments = [];
  void getPostComments(String? postId) {
    postComments = [];
    emit(SocialGetPostCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dateTime')
        .get()
        .then((value) {
      for (var element in value.docs) {
        postComments.add(CommentModel.fromJson(element.data()));
      }
      emit(SocialGetPostCommentsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostCommentsErrorState());
    });
  }

  List<dynamic> postsnumber = [];

  void getpostsnumber() {
    postsnumber = [];
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] == uId) postsnumber.add(element.data());
      }
    });
  }

  void deletepost(String postid) {
    emit(SocialDeletePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('comments')
        .get()
        .then((value) {
      for (var element in value.docs) {
        element.reference.delete();
        emit(SocialDeletePostSuccessState());
        getPosts();
        getpostsnumber();
      }
    }).catchError(onError);
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('Likes')
        .get()
        .then((value) {
      for (var element in value.docs) {
        element.reference.delete();
        emit(SocialDeletePostSuccessState());
        getPosts();
        getpostsnumber();
      }
    }).catchError(onError);

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .delete()
        .then((value) {
      emit(SocialDeletePostSuccessState());
      getPosts();
      getpostsnumber();
    }).catchError((e) {
      emit(SocialDeletePostErrorState());
      print(e.toString());
    });
  }

  bool isDark = false;

  void changeSocialAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
      CacheHelper.putBool(key: "isDark", value: isDark).then((value) {
        emit(SocialChangeAppModeState());
      });
    }
  }
}
