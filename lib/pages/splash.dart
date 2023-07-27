import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trustchain_gui/ui/ui.dart';


class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.all(100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Trustchain", 
                  style: GoogleFonts.inconsolata(
                    fontSize: 120,
                    fontWeight: FontWeight.bold,
                    color: UiKit.palette.icon),),
                Text("Decentralised public key infrastructure", style: GoogleFonts.inconsolata(fontSize: 20),)
              ],
            ),
          ),
        ),
      ],
      
    );
  }
}



// class BigCard extends StatelessWidget {
//   const BigCard({
//     super.key,
//     required this.word,
//   });

//   final WordPair word;

//   @override
//   Widget build(BuildContext context) {
//     var theme = Theme.of(context);
//     var style = theme.textTheme.displayMedium!.copyWith(
//       color: theme.colorScheme.onPrimary,

//     );
//     return Card(
//       color: theme.primaryColor,
//       child: Padding(
//         padding: const EdgeInsets.all(30),
//         child: Text(word.asLowerCase,
//                     style: style,
//                     semanticsLabel: word.asPascalCase,),
//       ),
//     );
//   }
// }