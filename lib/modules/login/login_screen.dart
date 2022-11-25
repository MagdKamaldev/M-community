// ignore_for_file: use_key_in_widget_constructors, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:udemy_course/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  defaultFormField(
                    onSubmit: (){},
                     onChanged: (){},
                      onTab: () {},
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: "E-Mail",
                      prefix: Icons.email,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "E-mail should not be empty";
                        }
                      }),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    onSubmit: (){},
                    onChanged: (){},
                      onTab: () {},
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      label: "password",
                      prefix: Icons.lock,
                      suffix:
                          isPassword ? Icons.visibility : Icons.visibility_off,
                      suffixPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      isPassword: isPassword,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "password must not be empty";
                        }
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        print(emailController.text);
                        print(passwordController.text);
                      }
                    },
                    text: "login",
                    isUpperCase: true,
                    radius: 10.0,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Register Now',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
