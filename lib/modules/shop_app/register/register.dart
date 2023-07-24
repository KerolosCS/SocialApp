import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/shop_app/Register/cubit/states.dart';
import 'package:social_app/modules/shop_app/login/log_in.dart';
import '../../../constants/const.dart';
import '../../../defaults.dart';
import '../../../layout/shopApp/shop_layout.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';

// ignore: must_be_immutable
class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  ShopRegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.RegisterModel?.status == true) {
              CacheHelper.saveData(
                      key: 'token', value: state.RegisterModel?.data?.token)
                  .then((value) {
                token = CacheHelper.getData(key: 'token');
                print("Token from Login : $token");
                navigateToWithReplacment(context, const ShopLayout());
              });

              toastShow(
                backColor: Colors.green,
                txt:
                    'Created account Successfully welcom , ${state.RegisterModel?.data?.name}',
              );
            } else {
              // print(state.RegisterModel?.message);
              toastShow(
                backColor: Colors.red,
                txt: "${state.RegisterModel?.message}",
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
                          "Register now to discover our offers !",
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
                          suffix: ShopRegisterCubit.get(context).suffix,
                          onSubmit: (value) {},
                          isPassword: ShopRegisterCubit.get(context).vis,
                          onPressedSuffix: () {
                            ShopRegisterCubit.get(context).visiablePassword();
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
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => Container(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
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
                                navigateTo(context, LogInScreen());
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
