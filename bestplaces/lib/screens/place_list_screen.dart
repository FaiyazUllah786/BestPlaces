import 'package:bestplaces/providers/best_places.dart';

import '../screens/add_place_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Places"),
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AddPlaceScreen.routeName),
                icon: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<BestPlaces>(context, listen: false)
              .fetchAndsSetPlaces(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<BestPlaces>(builder: (ctx, bestPlaces, ch) {
                      if (bestPlaces.items.isEmpty) {
                        return Center(
                          child: Text('No Places is Added Yet!'),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: bestPlaces.items.length,
                            itemBuilder: (ctx, i) => Container(
                                  padding: EdgeInsets.all(10),
                                  height: 300,
                                  width: double.infinity,
                                  child: Image.file(
                                    bestPlaces.items[i].image,
                                    fit: BoxFit.cover,
                                  ),
                                ));
                      }
                    }),
        ));
  }
}
