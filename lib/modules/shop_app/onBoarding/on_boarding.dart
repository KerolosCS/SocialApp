import 'package:flutter/material.dart';
import 'package:social_app/defaults.dart';
import 'package:social_app/shared/colors.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String img;
  final String title;
  final String body;
  BoardingModel(this.img, this.title, this.body);
}

// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageViewController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      "assets/images/pageview.jpg",
      "Title 1 ",
      "Body 1",
    ),
    BoardingModel(
      "assets/images/pageview.jpg",
      "Title 2 ",
      "Body 2",
    ),
    BoardingModel(
      "assets/images/pageview.jpg",
      "Title 3 ",
      "Body 3",
    ),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then(
      (value) {
        if (value) {
          navigateToWithReplacment(
            context,
            null, // LogInScreen(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                submit();
              },
              child: const Text(
                "Skip",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (value) {
                    if (value == 2) {
                      // ignore: avoid_print
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: pageViewController,
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: pageViewController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (!isLast) {
                        pageViewController.nextPage(
                          duration: const Duration(seconds: 2),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      } else {
                        submit();
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel b1) => Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(b1.img),
            ),
          ),
          Text(
            b1.title,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              b1.body,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      );
}
