import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/application_layer/bloc/home_bloc/home_bloc.dart';
import 'package:progress_soft_app/application_layer/pages/home_page/widgets/post_list_shimmer_loading.dart';
import 'package:progress_soft_app/application_layer/resources/fonts_manager.dart';
import 'package:progress_soft_app/application_layer/resources/values_manager.dart';
import 'package:progress_soft_app/core/constants/strings.dart';
import 'package:progress_soft_app/core/widgets/main_text_field_widget/main_text_field_widget.dart';
import 'package:progress_soft_app/data_layer/models/posts_model/posts_model.dart';

class PostListWidget extends StatefulWidget {
  const PostListWidget({super.key});

  @override
  State<PostListWidget> createState() => _PostListWidgetState();
}

class _PostListWidgetState extends State<PostListWidget> {
  @override
  void initState() {
    super.initState();
    HomeBloc homeBloc = context.read<HomeBloc>();
    homeBloc.add(ExecuteListOfPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
          child: MainTextField(
            hintText: Strings.search.tr(),
            isRequired: false,
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            onChanged: (String value) {
              context
                  .read<HomeBloc>()
                  .add(SearchListOfPosts(searchValue: value));
            },
          ),
        ),
        BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          List<PostsModel>? data = context.read<HomeBloc>().listDisplay;
          if (state is SuccessAPI) {
            return Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: AppPadding.p12,
                  bottom: AppPadding.p24,
                ),
                itemCount: data?.length ?? 0,
                itemBuilder: (context, index) =>
                    _cardWidget(data?[index] ?? PostsModel()),
              ),
            );
          } else {
            return const PostsShimmerLoading();
          }
        }),
      ],
    );
  }

  Widget _cardWidget(PostsModel data) => Container(
        margin: const EdgeInsets.only(
            left: AppMargin.m16, right: AppMargin.m16, bottom: AppMargin.m12),
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
            vertical: AppPadding.p8,
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                data.title ?? '',
                maxLines: 1,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: FontSize.s23),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                data.body ?? '',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Theme.of(context).hintColor),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
}
