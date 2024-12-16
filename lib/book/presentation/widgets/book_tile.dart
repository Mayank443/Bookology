import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/book.dart';
import '../screens/book_detail_screen.dart';

class BookTile extends StatelessWidget {
  const BookTile({
    super.key,
    required this.h,
    required this.w,
    required this.url,
    required this.tittle,
    required this.author,
    required this.downloads,
    required this.book,
    required this.language
    });

    final String url;
  final String tittle;
  final String author;
  final int downloads;
  final double h; 
  final double w; 
  final Book book;
  final String language;
  @override
  Widget build(BuildContext context) {
    int a =downloads >= 50000 ? 5
      : (downloads >= 35000) ? 4
      : (downloads >= 15000) ? 3
      : (downloads >= 7000) ? 2
      : 1;
    String error = (language == "zh")?
     '!! This Book is in Mandrin'
     :"" ;
    return InkWell(
      onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
            BookDetailScreen(book:book ),
          ),
        );
      },
      child: Container( 
        height: h,
        width: w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
            image: AssetImage("assets/Images/bl05.jpeg"),
            fit: BoxFit.cover,
            opacity: .75
          )
        ),
        margin: const EdgeInsets.only(
          right :10,
          left: 15,
          top: 10,
        ),
        child: Row(
          children: [
            SizedBox(
              width: w*.02,
            ),
            SizedBox(
              height: h*.94,
              width: w*.4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: CachedNetworkImage(
                              imageUrl: url,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const SizedBox(
                                width: 50,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
              ),
            ),
            SizedBox(
              width: w*.05,
            ),
            Container(
              width: w*.45,
              height: h*.94,
              decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          image: DecorationImage(
            image: AssetImage("assets/Images/bl03.jpg"),
            fit: BoxFit.cover,
            opacity: .75
          )
        ),

              child: Column(
                children: [
                  SizedBox(
                    height: h*.15,
                  ),
                  SizedBox(
                    height: h*.35,
                    child: Text(tittle ,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.oldenburg(
                        textStyle: TextStyle(  
                          fontFamily: "Chinese",
                          fontSize: 19,
                        )
                      )
                    ),
                  ),
                  SizedBox(
                    height: h*.05,
                    child:  Text(error,style: TextStyle(fontSize: 10 ),)
                  ),
                  SizedBox(
                    height: h*.25,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("By $author",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.oldenburg(
                          textStyle: TextStyle(  
                            fontStyle: FontStyle.italic,
                            fontSize: 11,
                          )
                        )
                      ),
                    ),
                  ),
                  SizedBox(
                    width: w*.3,
                    child: Row(
                      children: 
                        List.generate(a ,(index){
                          return Icon(Icons.star,color: Colors.amber,);
                        }
                        )
                    ),
                  ),
                  
                  SizedBox(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                       'Downloads - $downloads',
                       style: GoogleFonts.oldenburg(
                          textStyle: TextStyle( 
                            fontSize: 9,
                          )
                        )
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ); 
  }
}