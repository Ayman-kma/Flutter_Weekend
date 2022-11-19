import 'package:flutter/material.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../states/theme_mode_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategorySection extends ConsumerWidget {
  const CategorySection({
    super.key,
    required this.title,
    required this.id,
  });

  final String title;
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeModeState state = ref.watch(themeProvider);
    final selectedItem = ref.watch(SelectCategoryProvider);

    return Card(
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.shadow,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      color: selectedItem == id
          ? Theme.of(context).colorScheme.primary
          : Colors.white,
      child: InkWell(
        onTap: () {
          ref.read(SelectCategoryProvider.notifier).state = id;
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: selectedItem == id
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                title,
                style: TextStyle(
                    color: selectedItem == id ? Colors.white : Colors.black,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
