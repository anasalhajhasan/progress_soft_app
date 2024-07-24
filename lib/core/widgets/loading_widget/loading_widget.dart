import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        key: const ObjectKey(null),
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      );
}
