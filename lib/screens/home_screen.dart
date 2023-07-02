import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/category_bloc/user_bloc.dart';

import 'package:test_task/screens/category_screen.dart';
import '../models/Cart_model.dart';

import '../models/dishes_model.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<HomeScreen> {
  int screen_index = 1;
  final screens = [
    mainScreen(),
    CategoryScreen(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: screens[screen_index],
          bottomNavigationBar: NavigationBarTheme(
            data: const NavigationBarThemeData(backgroundColor: Colors.white),
            child: NavigationBar(
              selectedIndex: screen_index,
              onDestinationSelected: (index) =>
                  setState(() => this.screen_index = index),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'home'),
                NavigationDestination(icon: Icon(Icons.rocket), label: 'yes'),
                NavigationDestination(
                    icon: Icon(Icons.arrow_back), label: '12312'),
                NavigationDestination(
                    icon: Icon(Icons.house), label: 'y12312es'),
              ],
            ),
          )),
    );
  }
}

Widget mainScreen() {
  return SingleChildScrollView(
    child: BlocProvider(
      create: (context) => UserBloc()..add(LoadUserEvent()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status.isError) {
            return const Center(
              child: Text('error'),
            );
          }
          if (state.status.isSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.location_city_outlined),
                      Column(
                        children: [Text('asdasd'), Text('asdasda')],
                      ),
                    ],
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.category.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        state.category[index].imageUrl ?? '0'),
                                    fit: BoxFit.cover)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, top: 12, right: 150),
                              child: Text(
                                state.category[index].name ?? '0',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'SF-Pro',
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    ),
  );
}
