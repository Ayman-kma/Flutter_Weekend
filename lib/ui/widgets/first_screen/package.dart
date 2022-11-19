// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Package extends ConsumerWidget {
  const Package({

    required this.title,
    required this.features,
  });

   final String title;
  final List<dynamic> features;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  final selectedItem = ref.watch(SelectCategoryProvider);
    List<Widget> data = [];

    features.forEach((e) => {data.add(detailPackage(e.toString()))});
    return Card(
      elevation: 5,
      shadowColor: Theme.of(context).colorScheme.shadow,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      color: Theme.of(context).colorScheme.primary,
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).colorScheme.primary,
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ...data,
            ],
          ),
        ),
      ),
    );
  }
}

// class detailPackage extends StatelessWidget {
//   String title;
//   detailPackage({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

//   }
// }

Widget detailPackage(String title) {
  return Align(
    alignment: Alignment.topLeft,
    child: Text(
      textAlign: TextAlign.start,
      "\u2022 " + title,
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
  );
}
