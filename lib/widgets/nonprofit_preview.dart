import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:altruity/providers/nonprofit.dart';
import 'package:altruity/screens/nonprofit_screen.dart';

class NonprofitPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nonprofit = Provider.of<Nonprofit>(context, listen: false);
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NonProfitScreen(nonprofit)));
        },
        child: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Container(
                height: 150,
                //width: double.infinity,
                child: nonprofit.coverPhoto.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Image.network(
                              nonprofit.coverPhoto,
                              width: 150,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: double.infinity,
                                  width: 300,
                                  child: Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          nonprofit.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            0.0, 3.0, 0.0, 3.0),
                                        width: 200,
                                        height: 20,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: nonprofit.tags.length,
                                          itemBuilder: (ctx, i) => Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0.0, 0.0, 6.0, 0.0),
                                            child: Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10.0, 0.0, 10.0, 0.0),
                                                child: Text(
                                                  nonprofit.tags[i],
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ),
                                              //margin: EdgeInsets.all(3.0),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.black12,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(nonprofit.description),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
