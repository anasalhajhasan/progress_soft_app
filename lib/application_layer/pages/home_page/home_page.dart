import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/application_layer/bloc/home_bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:progress_soft_app/application_layer/pages/home_page/widgets/post_list_widget.dart';
import 'package:progress_soft_app/application_layer/pages/home_page/widgets/profile_tab_widget.dart';
import 'package:progress_soft_app/application_layer/resources/color_manager.dart';
import 'package:progress_soft_app/application_layer/resources/values_manager.dart';
import 'package:progress_soft_app/core/constants/assets.dart';
import 'package:progress_soft_app/core/constants/strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavBlocState>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Image.asset(
                Assets.logo,
                height: AppSize.s50,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.language),
                  onPressed: () => _changeLanguage(context),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: Strings.home.tr(),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person),
                  label: Strings.profile.tr(),
                ),
              ],
              currentIndex: context.read<BottomNavBloc>().selectedScreen,
              selectedItemColor: ColorManager.white,
              onTap: (index) => context
                  .read<BottomNavBloc>()
                  .add(NavigationChangeIndexEvent(indexOfScreen: index)),
            ),
            body: _buildCurrentScreen(
                context.read<BottomNavBloc>().selectedScreen),
          ),
        );
      },
    );
  }

  void _changeLanguage(BuildContext context) {
    final newLocale = context.locale == const Locale('en')
        ? const Locale('ar')
        : const Locale('en');
    context.setLocale(newLocale);
  }

  Widget _buildCurrentScreen(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const PostListWidget();
      case 1:
        return const ProfileTabWidget();
      default:
        return const PostListWidget();
    }
  }
}
