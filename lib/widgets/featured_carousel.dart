import 'package:altruity/providers/nonprofit.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';

import 'package:altruity/providers/nonprofits.dart';
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
        height: 255,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 0.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Featured',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          CarouselSlider(
            items: _getCarouselWidgets(featuredNonprofits),
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: false,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: featuredNonprofits.map((nonprof) {
              int index = featuredNonprofits.indexOf(nonprof);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
        ]),
      ),
    );
  }

  List<Widget> _getCarouselWidgets(List<Nonprofit> featuredNonprofits) {
    return featuredNonprofits
        .map((nonprof) => InkWell(
                  child: Container(
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          Image.network(nonprof.imageUrls[0],
                              fit: BoxFit.cover, width: 1000.0),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black38,
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  nonprof.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
        ))
        .toList();
  }
}
