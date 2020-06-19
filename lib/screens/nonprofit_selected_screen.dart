import 'package:flutter/material.dart';

import 'package:altruity/providers/nonprofit.dart';

/*
      DISPLAYS THE FULL PAGE FOR THE NONPROFIT SELECTED BY THE USER
      General layout has: a back button at the top left => back to Discover Screen,
                          Nonprofit info:
                            name,
                            associated image,
                            tags,
                            full description
                          Donation options => Confirmation once selected: 
                            $5 $10 $20 $50 Monthly => $____ donation sent + confetti graphic OR ??? pop up to customize monthly amount ???
*/

class NonProfitSelectedScreen extends StatefulWidget {
  // the nonprofit selected from the previous screen is needed to pull the info from the Nonprofits list
  final Nonprofit selected;

  NonProfitSelectedScreen(this.selected);

  @override
  _NonProfitSelectedScreenState createState() =>
      _NonProfitSelectedScreenState();
}

class _NonProfitSelectedScreenState extends State<NonProfitSelectedScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(children: [
          ///BACK BUTTON -- returns to previous page (if there was no previous page it will not do anything)
          BackButton(),

          ///NONPROFIT NAME
          Padding(
            padding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 0.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.selected.title,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ),

          ///IMAGE -- if an image associated with the nonprofit is unavailable a default placeholder should load instead
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.selected.imageUrls.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.selected.imageUrls[0],
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://cdn.visa.com/cdn/assets/images/logos/visa/logo.png",
                      fit: BoxFit.cover,
                    ),
                  ),
          ),

          ///TAGS -- should be aligned to run under the image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 10.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.selected.tags.length,
                itemBuilder: (ctx, i) => Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 6.0, 0.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: Text(
                        widget.selected.tags[i],
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                        ),
                  ),
                ),
              ),
            ),
          ),

          ///DESCRIPTION
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.selected.description,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),

          ///DONATION OPTIONS -- FIXED TO BOTTOM OF SCREEN TO STAY IN PLACE WHEN SCROLLING?
          

        ]),
      ),
    );
  }
}