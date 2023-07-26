import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/defaults.dart';
import 'package:social_app/modules/shop_app/cubit/cubit.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import '../cubit/states.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 16),
                  defaultFormFeild(
                    controller: nameController,
                    type: TextInputType.name,
                    label: 'Name',
                    validate: (String? val) {
                      if (val!.isEmpty) {
                        return "Name must't be empty";
                      }
                      return null;
                    },
                    prefix: Icons.person,
                  ),
                  const SizedBox(height: 16),
                  defaultFormFeild(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'Email',
                    validate: (String? val) {
                      if (val!.isEmpty) {
                        return "Email must't be empty";
                      }
                      return null;
                    },
                    prefix: Icons.email,
                  ),
                  const SizedBox(height: 16),
                  defaultFormFeild(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: 'Phone',
                    validate: (String? val) {
                      if (val!.isEmpty) {
                        return "Phone number must't be empty";
                      }
                      return null;
                    },
                    prefix: Icons.phone,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      child: Text("UPDATE"),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        CacheHelper.clearData(key: 'token').then(
                          (value) {
                            navigateToWithReplacment(context, null);
                          },
                        );
                      },
                      child: Text("Logout"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          fallback: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
