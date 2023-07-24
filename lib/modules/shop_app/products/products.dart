import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/shopApp/categories_model.dart';
import 'package:social_app/models/shopApp/home_mode.dart';
import 'package:social_app/modules/shop_app/cubit/cubit.dart';
import 'package:social_app/shared/colors.dart';

import '../cubit/states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeData != null &&
              ShopCubit.get(context).cateModel != null,
          builder: (context) => productsBuilder(ShopCubit.get(context).homeData,
              ShopCubit.get(context).cateModel, context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(
          HomeMedel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model?.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e['image']}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                viewportFraction: 1.0,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoryItem(
                        categoriesModel.data!.data![index],
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 8,
                      ),
                      itemCount: categoriesModel!.data!.data!.length,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Products",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1.0 / 1.65, // width/height
                children: List.generate(
                  model!.data.products.length,
                  (index) => buildGridProduct(model, index, context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(HomeMedel model, index, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.data.products[index]['image']}'),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.data.products[index]['discount'] != 0)
                  Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        "DISCOUNT",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 5, right: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.data.products[index]['name']}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.data.products[index]['price']} EGP',
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(width: 5),
                      if (model.data.products[index]['discount'] != 0)
                        Text(
                          '${model.data.products[index]['old_price']}',
                          style: const TextStyle(
                            fontSize: 10.5,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: ShopCubit.get(context)
                                .favMap[model.data.products[index]['id']]!
                            ? defaultColor
                            : Colors.grey,
                        child: IconButton(
                          onPressed: () {
                            // ignore: avoid_print
                            print(model.data.products[index]['id']);
                            ShopCubit.get(context)
                                .changeFav(model.data.products[index]['id']);
                          },
                          icon: const Icon(
                            Icons.favorite_border_outlined,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel model) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100,
            color: Colors.black.withOpacity(0.7),
            child: Text(
              "${model.name}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
