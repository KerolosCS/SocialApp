import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/shopApp/fav_model.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../shared/colors.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // ShopCubit.get(context).getFavData();
        return ConditionalBuilder(
          condition: state
              is! ShopLoadingGetFavLightState, // ShopCubit.get(context).favModelFromWebsite!.data!.data!.isEmpty,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildFavItem(
                ShopCubit.get(context)
                        .favModelFromWebsite
                        ?.data
                        ?.data?[index] ??
                    ShopCubit.get(context).favModelFromWebsite?.data?.data?[0],
                context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            itemCount: ShopCubit.get(context)
                    .favModelFromWebsite
                    ?.data
                    ?.data
                    ?.length ??
                0,
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavItem(FavouritesData? favData, context) => Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${favData!.product!.image}'),
                    width: 120,
                    height: 120,
                  ),
                  if (favData.product?.discount != 0)
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
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${favData.product?.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            '${favData.product?.price} EGP',
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: defaultColor,
                            ),
                          ),
                          const SizedBox(width: 5),
                          if (favData.product?.discount != 0)
                            Text(
                              '${favData.product?.oldPrice}',
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
                                        .favMap[favData.product?.id] ??
                                    true
                                ? defaultColor
                                : Colors.grey,
                            child: IconButton(
                              onPressed: () {
                                // ignore: avoid_print
                                // print(model.data.products[index]['id']);
                                ShopCubit.get(context)
                                    .changeFav(favData.product!.id!);
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
              ),
            ],
          ),
        ),
      );
}
