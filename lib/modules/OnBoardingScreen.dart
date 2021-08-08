import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopmart/remoteNetwork/cacheHelper.dart';
import 'package:shopmart/shared/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'LoginScreen.dart';

class BoardingModel{
  late final String image;
  late final String title;
  late final String body;

   BoardingModel({
     required this.image,
     required this.body,
     required this.title,
});
}


class OnBoarding extends StatelessWidget {
  final PageController onBoardController = PageController();

  List<BoardingModel> boardingModel =
  [
    BoardingModel(
        image: 'assets/images/OnlineShop.png',
        body: 'Choose Whatever the Product you wish for with the easiest way possible using ShopMart',
        title: 'Explore'),
    BoardingModel(
        image: 'assets/images/Delivery.png',
        body: 'Yor Order will be shipped to you as fast as possible by our carrier',
        title: 'Shipping'),
    BoardingModel(
        image: 'assets/images/Payment.png',
        body: 'Pay with the safest way possible either by cash or credit cards',
        title: 'Make the Payment'),

  ];
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        actions:
        [
          TextButton(
              onPressed: ()
              {
                CacheHelper.saveData(key: 'ShowOnBoard', value: false).then((value){
                  if(value)
                    navigateAndKill(context, LoginScreen());

                });
              },
              child: Text('Skip',style: TextStyle(letterSpacing: 1),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Expanded(
                child: PageView.builder(
                  controller: onBoardController,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (index)
                  {
                    if(index == boardingModel.length - 1)
                      isLast = true;
                    else
                      isLast = false;
                  },
                  itemBuilder:(context,index) => onBoarding(boardingModel[index]),
                  itemCount: 3,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:
                [
                  SmoothPageIndicator(
                      controller: onBoardController,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.deepOrange,
                        expansionFactor: 4,
                        dotHeight: 10,
                        dotWidth: 20,
                        spacing: 10

                      ),
                      count: 3,
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: ()
                    {
                      if(isLast) {
                      CacheHelper.saveData(key: 'ShowOnBoard', value: false).then((value)
                      {
                        if(value)
                          navigateAndKill(context, LoginScreen());
                      });
                    } else {
                        onBoardController.nextPage(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios_rounded),
                  )
                ],
              )
            ],
          ),
        ),
      );
  }
  Widget onBoarding (model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}')),
      ),
      separator(0, 10),
      Text('${model.title}',style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold
      ),),
      separator(0, 10),
      Text('${model.body}',style: TextStyle(
        fontSize: 20,
      ),),
      separator(0, 50),

    ],
  );
}
