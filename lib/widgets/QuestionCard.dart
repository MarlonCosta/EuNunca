import 'package:bebo_games/widgets/SwippableCardStack.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class QuestionCard extends StatelessWidget {
  final CardContent content;
  final Color color;
  const QuestionCard({Key? key, required this.color, required this.content}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          color: color,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Align(
                alignment: Alignment.topCenter,
                child: Text("...${content.text}",
                    style: GoogleFonts.sen(
                        textStyle: const TextStyle(
                            color: Colors.white, fontSize: 24.0)))),
          ),
        ),
      ),
    );
  }
}
