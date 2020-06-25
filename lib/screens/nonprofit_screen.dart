import 'package:flutter/material.dart';

import 'package:altruity/providers/nonprofit.dart';
import 'package:altruity/widgets/donation_selection.dart';

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

class NonProfitScreen extends StatefulWidget {
  // the nonprofit selected from the previous screen is needed to pull the info from the Nonprofits list
  final Nonprofit selected;

  NonProfitScreen(this.selected);

  @override
  _NonProfitScreenState createState() => _NonProfitScreenState();
}

class _NonProfitScreenState extends State<NonProfitScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: new IconThemeData(color: Colors.black38),
            leading: BackButton(),
            backgroundColor: Colors.white,
            elevation: 1,
          ),
          body: Column(
            children: [
              ///BACK BUTTON -- returns to previous page (if there was no previous page it will not do anything)

              ///NONPROFIT NAME
              Padding(
                padding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 0.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.selected.title,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),

              ///IMAGE -- if an image associated with the nonprofit is unavailable a default placeholder should load instead
              ///TAGS -- should be aligned to run under image
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    //image
                    widget.selected.coverPhoto.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              widget.selected.coverPhoto,
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
                    //tags
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0),
                      width: 200,
                      height: 20,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.selected.tags.length,
                        itemBuilder: (ctx, i) => Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 6.0, 0.0),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 0.0, 10.0, 0.0),
                              child: Text(
                                widget.selected.tags[i],
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            //margin: EdgeInsets.all(3.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              ///DESCRIPTION -- full description of the nonprofit
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Text(
                      //filler text to test scrolling
                      //"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vestibulum nisi id accumsan sagittis. Praesent sit amet porta ipsum. Cras venenatis nec sem quis ullamcorper. Ut lectus massa, varius nec lorem sit amet, vulputate vehicula lectus. Pellentesque congue odio velit, non aliquet leo malesuada sed. Mauris eu erat in sem lobortis placerat. Nulla eget tincidunt nisi, eu molestie libero. Maecenas mattis dui quis augue molestie vestibulum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed ultrices purus a erat viverra accumsan. Vestibulum semper, odio vitae ornare molestie, odio ligula vehicula ex, eu iaculis leo ante eu nulla. Cras velit sapien, imperdiet sit amet ligula id, pellentesque dapibus velit. Sed pulvinar eleifend leo quis bibendum. Curabitur sit amet eleifend libero. Duis in semper nisl. Aenean sit amet mauris in diam fringilla vehicula ac ut magna. Proin quis iaculis ex. Praesent egestas consectetur euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Curabitur pharetra est ex. Sed vel rhoncus mauris. Fusce cursus, nisi non dictum commodo, ligula felis malesuada nisl, ut fermentum orci neque id nisi. Duis commodo elit et metus sollicitudin, vel euismod diam varius. Duis ornare aliquam massa ut tempor. Aenean id odio nec leo fringilla facilisis. Sed ornare turpis neque, eget posuere elit tristique at. Donec ut metus gravida, imperdiet nisl in, dictum magna. Vivamus libero nulla, vulputate eu ante at, pellentesque lacinia diam. Duis efficitur neque eu libero congue tincidunt. Morbi mollis efficitur felis in sodales. In nec purus commodo, cursus magna sit amet, ullamcorper enim. Donec nunc augue, placerat quis pretium sit amet, tincidunt quis diam. Donec porta et turpis quis vestibulum. Nulla vel orci vitae nulla egestas venenatis vel at diam. Nullam pellentesque risus at libero lobortis, sit amet tincidunt nisl semper. Cras eu hendrerit libero. In hac habitasse platea dictumst. Etiam eu porta lorem. Curabitur suscipit quam ac laoreet vestibulum. Cras molestie convallis est, sed condimentum ipsum malesuada ut. Curabitur rhoncus tristique laoreet. Pellentesque justo mi, ornare placerat mauris id, tincidunt pretium leo. Pellentesque tempus arcu rutrum magna scelerisque, in vulputate ex egestas. Duis suscipit cursus lorem eu rutrum."
                      widget.selected.description,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),

              ///DONATION OPTIONS
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    color: Color.fromRGBO(247, 182, 0, 100),
                    child: Text('Donate Now'),
                    onPressed: () => _showDonationOptions(),
                  )
                  //DonationSelection(),
                  )
            ],
          ),
        ),
      ),
    );
  }

  void _showDonationOptions() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return DonationSelection();
        });
  }
}
