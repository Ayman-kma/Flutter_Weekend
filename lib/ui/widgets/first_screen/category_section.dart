import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../states/theme_mode_state.dart';
 
class CategorySection extends ConsumerWidget {
  const CategorySection({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeModeState state = ref.watch(themeProvider);

    return Card(
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.shadow,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: InkWell(
          onTap: () => {},
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  title,
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
              ],
            ),
          )),
    );
  }
}
