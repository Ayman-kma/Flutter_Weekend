import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/widgets/first_screen/category_section.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../widgets/first_screen/info_card.dart';
import '../widgets/first_screen/theme_card.dart';
import '../widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference eventData = FirebaseFirestore.instance.collection("Event");

final getEvent =
    StreamProvider.autoDispose<QuerySnapshot>((ref) => eventData.snapshots());

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  get itemBuilder => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var eventData = ref.watch(getEvent);

    return Material(
      color: Theme.of(context).colorScheme.background,
      child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            const Header(text: 'app_name'),

            const SizedBox(height: 8),
            eventData.when(
              data: ((data) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CategorySection(
                        title: "category1 ",
                      ),
                      CategorySection(
                        title: "category 2 ",
                      ),
                      CategorySection(
                        title: "category 3 ",
                      ),
                      CategorySection(
                        title: "category 4 ",
                      ),
                    ],
                  ),
                );
              }),
              error: (Object error, StackTrace? stackTrace) {
                return Text(error.toString());
              },
              loading: () {
                return CircularProgressIndicator();
              },
            ),

            /// Example: Good way to add space between items without using Paddings
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Divider(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(.4),
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [PlaceItem(), PlaceItem(), PlaceItem()],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Communites",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 30)),
            SingleChildScrollView(
              child: Column(
                children: [CategoryItem(), CategoryItem(), CategoryItem()],
              ),
            ),

            SizedBox(height: 36),
          ]),
    );
  }
}

class PlaceItem extends StatelessWidget {
  const PlaceItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.blue,
      ),
      height: 130,
      width: 300,
      child: Row(
        children: [
          Text("image 1"),
          Text("place 1"),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.blue,
      ),
      height: 200,
      child: Row(
        children: [
          Text("image 1"),
          Column(
            children: [
              Text("name"),
              Text("description"),
            ],
          ),
        ],
      ),
    );
  }
}
