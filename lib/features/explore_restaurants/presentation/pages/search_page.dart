import 'package:auto_route/auto_route.dart';
import 'package:dicoding_final/core/commons/widgets/loading_widget.dart';
import 'package:dicoding_final/core/commons/widgets/network_error_widget.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/cubit/explore_restaurants_cubit.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/widgets/search_widget/appbar.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/widgets/search_widget/lottie_state.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/widgets/shared/restaurant_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static const routeName = '/search';

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    void searchRestaurant(String restaurantName) {
      context.read<ExploreRestaurantsCubit>().searchRestaurant(restaurantName);
    }

    void retrySearch() {
      context.read<ExploreRestaurantsCubit>().searchRestaurant('');
    }

    return Scaffold(
      body: BlocConsumer<ExploreRestaurantsCubit, ExploreRestaurantsState>(
        listener: (context, state) {
          if (state is SearchError) {
            context.messenger.hideCurrentSnackBar();
            context.messenger
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              AppBarWidget(
                controller: controller,
                searchRestaurant: searchRestaurant,
              ),
              if (state is GetRestaurantsInitial)
                const LottieState(lottieAsset: AppConstant.searchLottie),
              if (state is SearchLoading)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: LoadingWidget(),
                ),
              if (state is SearchLoaded)
                SliverList.separated(
                  itemCount: state.restaurants.length,
                  itemBuilder: (_, index) {
                    final restaurant = state.restaurants[index];
                    return RestaurantTile(restaurant: restaurant);
                  },
                  separatorBuilder: (_, __) => Gap.h8,
                ),
              if (state is SearchLoaded && state.restaurants.isEmpty)
                const LottieState(lottieAsset: AppConstant.emptyLottie),
              if (state is SearchError &&
                  state.message.contains(AppConstant.noInternetConnection))
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: NetworkErrorWidget(onRetry: retrySearch),
                ),
            ],
          );
        },
      ),
    );
  }
}
