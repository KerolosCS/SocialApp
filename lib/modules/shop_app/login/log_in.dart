// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constants/const.dart';
// import 'package:fluttertoast/fluttertoast.dart';R
import 'package:social_app/defaults.dart';
// import 'package:social_app/modules/social_app/cubit/cubit.dart';
import 'package:social_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:social_app/modules/shop_app/login/cubit/states.dart';
import 'package:social_app/modules/shop_app/register/register.dart';
import 'package:social_app/layout/shopApp/shop_layout.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
// import 'package:social_app/shared/network/remote/dio_helper.dart';

// ignore: must_be_immutable
class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel?.status == true) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel?.data?.token)
                  .then((value) {
                token = CacheHelper.getData(key: 'token');
                print("Token from Login : $token");
                navigateToWithReplacment(context, const ShopLayout());
              });

              toastShow(
                backColor: Colors.green,
                txt: 'Login done successfully',
              );
            } else {
              print(state.loginModel?.message);
              toastShow(
                backColor: Colors.red,
                txt: 'Please Cheek your password or Email',
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(color: Colors.black, fontSize: 34),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Login now to discover our offers !",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormFeild(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email',
                            prefix: Icons.email,
                            validate: (String? val) {
                              if (val!.isEmpty) {
                                return 'Email musn\'t be empty';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        defaultFormFeild(
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          label: 'password',
                          prefix: Icons.lock_outlined,
                          suffix: ShopLoginCubit.get(context).suffix,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passController.text,
                              );
                              // token = ShopLoginCubit.get(context)
                              //     .loginModel
                              //     ?.data
                              //     ?.token;
                            }
                          },
                          isPassword: ShopLoginCubit.get(context).vis,
                          onPressedSuffix: () {
                            ShopLoginCubit.get(context).visiablePassword();
                          },
                          validate: (String? val) {
                            if (val!.isEmpty) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // ignore: sized_box_for_whitespace
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => Container(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passController.text,
                                  );
                                }
                              },
                              child: const Text(
                                "Login",
                              ),
                            ),
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account ?"),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, ShopRegisterScreen());
                              },
                              child: const Text(
                                "Register",
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
        },
      ),
    );
  }
}
