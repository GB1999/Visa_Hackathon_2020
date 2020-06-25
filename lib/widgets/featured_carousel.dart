import 'package:altruity/providers/nonprofit.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';

import 'package:altruity/providers/nonprofits.dart';
import 'package:altruity/screens/nonprofit_screen.dart';
import 'package:provider/provider.dart';

class FeaturedCarousel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FeaturedCarouselState();
  }
}

class _FeaturedCarouselState extends State<FeaturedCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final featuredNonprofitsData =
        Provider.of<Nonprofits>(context, listen: false);
    final featuredNonprofits = featuredNonprofitsData.nonprofits;
    return Material(
      child: Container(
        height: 400,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Featured',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
            Expanded(
              child: Stack(children: [
                CarouselSlider(
                  items: _getCarouselWidgets(featuredNonprofits, context),
                  options: CarouselOptions(
                      height: 400,
                      autoPlay: true,
                      enlargeCenterPage: false,
                      aspectRatio: 2.0,
                      viewportFraction: 1,
                      autoPlayInterval: Duration(seconds: 5),
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),
                Positioned(
                  bottom: 140,
                  left: (MediaQuery.of(context).size.width-40)/2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: featuredNonprofits.map((nonprof) {
                      int index = featuredNonprofits.indexOf(nonprof);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Color.fromRGBO(0, 0, 0, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getCarouselWidgets(
      List<Nonprofit> featuredNonprofits, BuildContext context) {
    return featuredNonprofits
        .map(
          (nonprof) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child:  Image.network(nonprof.coverPhoto,
                              fit: BoxFit.cover,
                              //height: 100,
                              width: double.infinity),
                        
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NonProfitScreen(nonprof)));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          nonprof.title,
                          style: Theme.of(context).textTheme.headline1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      nonprof.description,
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
    // Container(
    //       child: Center(
    //         child: Image.network(nonprof.imageUrls[0], fit: BoxFit.cover, height: 175,)
    //       ),
    //     )).toList();
  }
}
