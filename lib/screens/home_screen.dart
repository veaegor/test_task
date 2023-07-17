import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:test_task/category_bloc/user_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task/screens/category_screen.dart';
import 'cart_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<HomeScreen> {
  int screen_index = 0;
  final screens = [
    mainScreen(),
    CategoryScreen(categoryName: 'asd',),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: screens[screen_index],
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: const NavigationBarThemeData(backgroundColor: Colors.white,),
          child: NavigationBar(
            height: 70,
            indicatorColor: Colors.white.withOpacity(0),
            selectedIndex: screen_index,
            onDestinationSelected: (index) =>
                setState(() => screen_index = index),
            destinations:  [
              NavigationDestination(icon: SvgPicture.asset('lib/assets/bottom_bar/home.svg',color: Colors.grey,), label: 'home',
              selectedIcon: SvgPicture.asset('lib/assets/bottom_bar/home.svg',color: const Color(0xff3364E0),),),
              NavigationDestination(icon: SvgPicture.asset('lib/assets/bottom_bar/search.svg',color: Colors.grey,), label: 'yes',
                selectedIcon: SvgPicture.asset('lib/assets/bottom_bar/search.svg',color: const Color(0xff3364E0),),),
              NavigationDestination(
                  icon: SvgPicture.asset('lib/assets/bottom_bar/bag.svg',color: Colors.grey,), label: '12312',
                selectedIcon: SvgPicture.asset('lib/assets/bottom_bar/bag.svg',color: const Color(0xff3364E0),),),
              NavigationDestination(
                  icon: SvgPicture.asset('lib/assets/bottom_bar/profile.svg',color: Colors.grey,), label: 'y12312es',
                selectedIcon: SvgPicture.asset('lib/assets/bottom_bar/profile.svg',color: const Color(0xff3364E0),),),
            ],
          ),
        ));
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
              final now = new DateTime.now();
              String formatter = DateFormat.yMMMMd('en_US').format(now);// 28/03/2020
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                     Row(
                      children: [
                        const Icon(Icons.location_city_outlined),
                        Column(
                          children: [Text(formatter), const Text('asdasda')],
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
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  _,
                                  MaterialPageRoute(builder: (_)=> CategoryScreen(categoryName: state.category[index].name))
                                );
                              },
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
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'SF-Pro',
                                    ),
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
