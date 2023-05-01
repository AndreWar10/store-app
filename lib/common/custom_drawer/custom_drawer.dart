import 'package:flutter/material.dart';
import 'package:store_app/common/custom_drawer/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          DrawerTile(title: "Inicio", iconData: Icons.home, page: 0),
          DrawerTile(title: "Produtos", iconData: Icons.list, page: 1),
          DrawerTile(title: "Meus Pedidos", iconData: Icons.playlist_add_check, page: 2),
          DrawerTile(title: "Lojas", iconData: Icons.location_on, page: 3),
        ],
      ),
    );
  }
}
