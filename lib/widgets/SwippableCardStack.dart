import 'dart:convert';

import 'package:bebo_games/widgets/QuestionCard.dart';
import 'package:flutter/material.dart';

import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:random_color/random_color.dart';

class SwipabbleCardStack extends StatefulWidget {
  const SwipabbleCardStack({Key? key}) : super(key: key);

  @override
  _SwipabbleCardStackState createState() => _SwipabbleCardStackState();
}

class _SwipabbleCardStackState extends State<SwipabbleCardStack> {
  List<CardContent> cardContent = [];

  List<Color> colors = [];
  int cardCount = 0;

  @override
  void initState() {
    if (cardContent.isEmpty) getData();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    CardController controller = CardController();
    if (colors.length < cardContent.length) fillColors();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: TinderSwapCard(
        orientation: AmassOrientation.BOTTOM,
        totalNum: cardContent.length,
        stackNum: 3,
        swipeEdge: 4.0,
        maxHeight: MediaQuery.of(context).size.height * 0.9,
        maxWidth: MediaQuery.of(context).size.width * 0.9,
        minHeight: MediaQuery.of(context).size.height * 0.89,
        minWidth: MediaQuery.of(context).size.width * 0.89,
        allowVerticalMovement: false,
        cardBuilder: (context, index) {
          QuestionCard newCard = QuestionCard(
              key: ValueKey("card$cardCount"),
              color: colors[index],
              content: cardContent[index]);
          return newCard;
        },
        cardController: controller,
        swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
          if (orientation == CardSwipeOrientation.LEFT ||
              orientation == CardSwipeOrientation.RIGHT) {
            cardCount++;
          }
        },
      ),
    );
  }

  void fillColors() {
    while (colors.length < cardContent.length) {
      colors.add(getNewColor());
    }
  }

  void getData() async {
    String data = await DefaultAssetBundle.of(context).loadString("data/cards.json");

    var jsonData = json.decode(data);

    jsonData.forEach((item) {
      cardContent.add(CardContent.fromJson(item));
    });
  }
}

class CardContent {
  final String text;
  final bool over18;
  final String type;

  CardContent(this.text, this.over18, this.type);

  factory CardContent.fromJson(dynamic json) {
    return CardContent(json['text'] as String, json['over18'] as bool, json['type'] as String);
  }

}

Color getNewColor() {
  RandomColor _randomColor = RandomColor();

  Color _color =
      _randomColor.randomColor(colorBrightness: ColorBrightness.light);
  return _color;
}

