import 'package:dicoding_final/core/commons/widgets/loading_widget.dart';
import 'package:dicoding_final/core/commons/widgets/network_error_widget.dart';
import 'package:dicoding_final/core/commons/widgets/restaurant_tile_widget.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/features/search/presentation/cubit/search_cubit.dart';
import 'package:dicoding_final/features/search/presentation/widgets/appbar.dart';
import 'package:dicoding_final/features/search/presentation/widgets/lottie_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static const routeName = '/search';

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    void searchRestaurant(String restaurantName) {
      context.read<SearchCubit>().searchRestaurant(restaurantName);
    }

    void retrySearch() {
      context.read<SearchCubit>().searchRestaurant('');
    }

    return Scaffold(
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state is SearchError) {
            context.messanger.hideCurrentSnackBar();
            context.messanger
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
              if (state is SearchInitial)
                const LottieState(lottieAsset: AppConstant.searchLottie),
              if (state is SearchLoading)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: LoadingWidget(),
                ),
              if (state is SearchLoaded)
                ...state.restaurants.map(
                  (restaurant) => SliverToBoxAdapter(
                    child: RestaurantTile(restaurant: restaurant),
                  ),
                ),
              if (state is SearchLoaded && state.restaurants.isEmpty)
                const LottieState(lottieAsset: AppConstant.emptyLottie),
              if (state is SearchError &&
                  state.message == AppConstant.noInternetConnection)
                NetworkErrorWidget(onRetry: retrySearch),
            ],
          );
        },
      ),
    );
  }
}
