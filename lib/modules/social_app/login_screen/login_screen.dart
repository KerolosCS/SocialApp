import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../defaults.dart';
import '../register/register.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

// ignore: must_be_immutable
class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
          listener: (context, state) {
        if (state is SocialLoginSuccessState) {
          toastShow(
            txt: "Login Successfully",
            backColor: Colors.green,
          );
        } else if(state is SocialLoginErrorState){
          toastShow(
            txt: "Failed to Login please check username and password",
            backColor: Colors.red,
          );
        }
      }, builder: (context, state) {
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
                        "Login now to Communicate with your friends",
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
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
                        suffix: SocialLoginCubit.get(context).suffix,
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            SocialLoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passController.text,
                            );
                          }
                        },
                        isPassword: SocialLoginCubit.get(context).vis,
                        onPressedSuffix: () {
                          SocialLoginCubit.get(context).visiablePassword();
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
                        condition: state is! SocialLoginLoadingState,
                        builder: (context) => Container(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
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
                              navigateTo(
                                context,
                                SocialRegisterScreen(),
                              ); //SocialRegisterScreen());
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
      }),
    );
  }
}
