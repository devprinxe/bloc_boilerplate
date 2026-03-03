import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_state.dart';

class MainWrapperScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainWrapperScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_filled), label: "Home"),

          // Use BlocSelector for the Cart tab only
          BottomNavigationBarItem(
            icon: BlocSelector<CartBloc, CartState, int>(
              selector: (state) {
                if (state is CartLoadedState) {
                  return state.products.length;
                }
                return 0;
              },
              builder: (context, itemCount) {
                return Badge(label: Text('$itemCount'), isLabelVisible: itemCount > 0, child: const Icon(Icons.shopping_cart_outlined));
              },
            ),
            activeIcon: BlocSelector<CartBloc, CartState, int>(
              selector: (state) => (state is CartLoadedState) ? state.products.length : 0,
              builder: (context, itemCount) {
                return Badge(label: Text('$itemCount'), isLabelVisible: itemCount > 0, child: const Icon(Icons.shopping_cart_rounded));
              },
            ),
            label: "Cart",
          ),
        ],
      ),
    );
  }
}
