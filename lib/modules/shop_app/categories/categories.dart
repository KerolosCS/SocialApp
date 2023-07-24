import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/shopApp/categories_model.dart';
import 'package:social_app/modules/shop_app/cubit/cubit.dart';
import '../cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(
            ShopCubit.get(context).cateModel!.data!.data![index],
          ),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Container(
              height: 1.5,
              color: Colors.grey[300],
            ),
          ),
          itemCount: ShopCubit.get(context).cateModel!.data!.data!.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage("${model.image}"),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              "${model.name}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
