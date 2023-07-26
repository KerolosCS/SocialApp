// ignore: must_be_immutable
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/socialApp/social_layout.dart';
import 'package:social_app/modules/Social_app/Register/cubit/states.dart';
import 'package:social_app/modules/social_app/register/cubit/cubit.dart';
import '../../../defaults.dart';
import '../login_screen/login_screen.dart';

// ignore: must_be_immutable
class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  SocialRegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          // if (state is SocialRegisterSuccessState) {
          //   if (state.RegisterModel?.status == true) {
          //     CacheHelper.saveData(
          //             key: 'token', value: state.RegisterModel?.data?.token)
          //         .then((value) {
          //       token = CacheHelper.getData(key: 'token');
          //       print("Token from Login : $token");
          //       navigateToWithReplacment(context, const SocialLayout());
          //     });

          //     toastShow(
          //       backColor: Colors.green,
          //       txt:
          //           'Created account Successfully welcom , ${state.RegisterModel?.data?.name}',
          //     );
          //   } else {
          //     // print(state.RegisterModel?.message);
          //     toastShow(
          //       backColor: Colors.red,
          //       txt: "${state.RegisterModel?.message}",
          //     );
          //   }
          // }

          if (state is SocialCreateUserSuccessState) {
            navigateTo(context, const SocialLayout());
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
                          "REGISTER",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(color: Colors.black, fontSize: 34),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Register now to Communicate with your Friends.",
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
                            controller: nameController,
                            type: TextInputType.name,
                            label: 'Name',
                            prefix: Icons.person,
                            validate: (String? val) {
                              if (val!.isEmpty) {
                                return 'Name musn\'t be empty';
                              }
                              return null;
                            }),
                        const SizedBox(height: 16),
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
                          suffix: SocialRegisterCubit.get(context).suffix,
                          onSubmit: (value) {},
                          isPassword: SocialRegisterCubit.get(context).vis,
                          onPressedSuffix: () {
                            SocialRegisterCubit.get(context).visiablePassword();
                          },
                          validate: (String? val) {
                            if (val!.isEmpty) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        defaultFormFeild(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          prefix: Icons.phone,
                          validate: (String? val) {
                            if (val!.isEmpty) {
                              return 'Please enter your phone';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // ignore: sized_box_for_whitespace
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => Container(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  SocialRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );

                                 
                                }
                              },
                              child: const Text(
                                "Register",
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
                            const Text("Already have an Account ?"),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, SocialLoginScreen());
                              },
                              child: const Text(
                                "Sign in",
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
