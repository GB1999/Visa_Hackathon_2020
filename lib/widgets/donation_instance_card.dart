import 'package:altruity/providers/nonprofit.dart';
import 'package:flutter/material.dart';
import 'package:altruity/models/donation.dart';
import 'package:altruity/providers/nonprofits.dart';
import 'package:provider/provider.dart';
class DonationInstanceCard extends StatelessWidget {
  Donation donation;
  DonationInstanceCard(this.donation);

  @override
  Widget build(BuildContext context) {
    Provider.of<Nonprofits>(context).fetchNonProfits();
    final donatedNonprofit = Provider.of<Nonprofits>(context).findById(donation.charityId);

    return Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                child: Container(
                  height: 120,
                  //width: double.infinity,
                  child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Image.network(
                              donatedNonprofit.coverPhoto,
                              width: 150,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: double.infinity,
                                  width: 300,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '\$${donation.amount}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                     Text(
                                        (donatedNonprofit.title != null)
                                            ? donatedNonprofit.title
                                            : " ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                         'Donated on ${donation.dateDonated}',
                              
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                ),
              ),
            ],
          ),
        );
  }
}