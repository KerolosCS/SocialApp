import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/modules/news_app/web_view.dart';

Widget defaultFormFeild({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  String? Function(String?)? validate,
  Function()? onTp,
  bool click = true,
  required String label,
  IconData? prefix,
  IconData? suffix,
  // bool ob = false,
  bool isPassword = false,
  void Function()? onPressedSuffix,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate,
      onTap: onTp,
      enabled: click,

      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
          onPressed: onPressedSuffix,
          icon: Icon(suffix),
        ),
        border: const OutlineInputBorder(),
      ),
      // style: const TextStyle(
      //   fontSize: 20,
      // ),
    );

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(
          context,
          WebViewScreen(url: article['url']),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              // ignore: sized_box_for_whitespace

              child: Container(
                height: 120,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Expanded(
                      child: Text(
                        "${article['title']}",
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Text(
                      "${article['publishedAt']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Container(
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        itemCount: list.length,
      ),
      fallback: (context) => isSearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, route) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => route,
      ),
    );

void navigateToWithReplacment(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (prevRoute) => false);

Future<bool?> toastShow({
  required String txt,
  required Color backColor,
}) async {
  return await Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: backColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

void printFullText(String txt) {
  final pattern = RegExp('.{1,800}');
  // ignore: avoid_print
  pattern.allMatches(txt).forEach((element) => print(element.group(0)));
}
