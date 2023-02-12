// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/modules/social_app/privacy_policy/privacy.dart';
import 'package:udemy_course/modules/social_app/register/cubit/register_cubit.dart';
import 'package:udemy_course/modules/social_app/register/cubit/register_states.dart';
import 'package:udemy_course/shared/styles/colors.dart';
import '../../../layout/Social_app/social_layout.dart';
import '../../../shared/components/components.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialAppRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateAndFinish(context, SocialLayout());
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
                            "REGISTER",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 24),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Register now to join our network",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 18, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return "Please enter your name";
                                }
                              },
                              onSubmit: () {},
                              onTab: () {},
                              onChanged: () {},
                              label: "User Name",
                              prefix: Icons.person),
                          SizedBox(
                            height: 15,
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
                              suffix: SocialRegisterCubit.get(context).suffix,
                              suffixPressed: () {
                                SocialRegisterCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              isPassword:
                                  SocialRegisterCubit.get(context).isPassword,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return "Password is too short";
                                }
                              },
                              onSubmit: () {},
                              onTab: () {},
                              onChanged: () {},
                              label: "password",
                              prefix: Icons.lock),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return "Please enter your phone number";
                                }
                              },
                              onSubmit: () {},
                              onTab: () {},
                              onChanged: () {},
                              label: "phone number",
                              prefix: Icons.phone),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                "    by Clicking Register you accept the  ",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              GestureDetector(
                                onTap: () {
                                  navigateTo(context, Privacy());
                                },
                                child: Text(
                                  "Privacy Policy",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: defaultColor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! SocialRegisterLoadingState,
                            builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialRegisterCubit.get(context)
                                        .userRegister(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            name: nameController.text,
                                            phone: phoneController.text);
                                  }
                                },
                                text: "register",
                                isUpperCase: true),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
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
