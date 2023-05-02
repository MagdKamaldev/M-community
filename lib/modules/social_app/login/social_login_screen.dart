// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/modules/social_app/login/cubit/login_states.dart';
import 'package:udemy_course/shared/networks/local/cache_helper.dart';
import '../../../layout/Social_app/Social_layout.dart';
import '../../../shared/components/components.dart';
import '../register/social_register_screen.dart';
import 'cubit/login_cubit.dart';


class SocialLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrodState) {
            showToast(text: state.error, state: ToasStates.error);
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: "uId", value: state.uId).then((value) {
              navigateAndFinish(context, SocialLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "LOGIN",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Login now to join our network",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return "Please enter your email adress";
                                }
                              },
                              onSubmit: () {},
                              onTab: () {},
                              onChanged: () {},
                              label: "E-mail adress",
                              prefix: Icons.email),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              suffix: SocialLoginCubit.get(context).suffix,
                              suffixPressed: () {
                                SocialLoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              isPassword:
                                  SocialLoginCubit.get(context).isPassword,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return "Password is too short";
                                }
                              },
                              onSubmit: () {
                                if (formKey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              onTab: () {},
                              onChanged: () {},
                              label: "password",
                              prefix: Icons.lock),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: State is! SocialLoginLoadingState,
                            builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                        
                                  }
                                },
                                text: "Login",
                                isUpperCase: true),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account ?"),
                              defaultTextButton(
                                  text: "register",
                                  onpressed: () {
                                    navigateTo(
                                      context,
                                      SocialRegisterScreen(),
                                    );
                                  })
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
