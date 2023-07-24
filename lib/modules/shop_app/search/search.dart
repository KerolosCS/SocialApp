// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/defaults.dart';
import 'package:social_app/models/shopApp/search_model.dart';
import 'package:social_app/modules/shop_app/search/cubit/cubit.dart';
import '../../../shared/colors.dart';
import '../cubit/cubit.dart';
import 'cubit/states.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var searchContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    defaultFormFeild(
                      controller: searchContoller,
                      type: TextInputType.name,
                      label: 'Search',
                      validate: (String? val) {
                        if (val!.isEmpty) {
                          return 'please enter anything ';
                        }
                        return null;
                      },
                      prefix: Icons.search,
                      onChange: (value) {
                        SearchCubit.get(context).search(value);
                      },
                    ),
                    const SizedBox(height: 10),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildSearchItem(
                              SearchCubit.get(context)
                                  .model
                                  ?.data
                                  ?.data?[index],
                              context),
                          separatorBuilder: (context, index) => Container(
                            height: 1,
                            color: Colors.grey[300],
                          ),
                          itemCount: SearchCubit.get(context)
                              .model!
                              .data!
                              .data!
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(Product? model, context) => Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model!.image}'),
                    width: 120,
                    height: 120,
                  ),
                  if (model.discount != 0)
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
                        '${model.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            '${model.price} EGP',
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: defaultColor,
                            ),
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                ShopCubit.get(context).favMap[model.id] ?? true
                                    ? defaultColor
                                    : Colors.grey,
                            child: IconButton(
                              onPressed: () {
                                // ignore: avoid_print
                                // print(model.datas[index]['id']);
                                ShopCubit.get(context).changeFav(model.id!);
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
