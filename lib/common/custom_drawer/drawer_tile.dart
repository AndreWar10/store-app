import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/models/page_manager.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {super.key,
      required this.iconData,
      required this.title,
      required this.page});

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    final int currentPage = context.watch<PageManager>().currentPage;

    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Icon(
                iconData,
                size: 32,
                color: currentPage == page ? Theme.of(context).primaryColor : Colors.grey[500],
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: currentPage == page ? Theme.of(context).primaryColor : Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
