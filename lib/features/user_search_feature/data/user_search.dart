import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/user_search_feature/bloc/user_search_bloc.dart';
import 'package:anexpress/features/user_search_feature/data/search_user_model.dart';
import 'package:anexpress/widgets/user_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSearch extends SearchDelegate<int> {
  final Bloc<UserSearchEvent, UserSearchState> areaSearchBloc;
  final int receiveCountryId;
  final int serviceId;
  String searchQueryParameterPassed;

  late SearchUserModel selectedUser;

  UserSearch(this.areaSearchBloc, this.receiveCountryId, this.serviceId,
      this.searchQueryParameterPassed)
      : super(
          searchFieldLabel: 'Search User',
          searchFieldStyle: TextStyle(
              color: AppColors.whiteA700,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      //primaryColor: AppColors.primary,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: AppColors.secondary,
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.transparent,
          // Status bar brightness (optional)
          statusBarIconBrightness:
              Brightness.light, // For Android (light icons)
          statusBarBrightness: Brightness.dark, // For iOS (light icons)
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for app bar
    return [
      IconButton(
          icon: Icon(
            Icons.clear,
            color: AppColors.whiteA700,
          ),
          onPressed: () {
            query = '';
            searchQueryParameterPassed = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        color: AppColors.whiteA700,
      ),
      onPressed: () {
        close(context, 0);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    'the query inside buildResults is $query'.log();

    return Center(
      child: SizedBox(
        height: 100,
        child: Card(
          color: Colors.grey.shade100,
          elevation: 10.0,
          child: Center(
            child: Text(
              '${selectedUser.name}',
              style: const TextStyle(fontSize: 22.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    'the query inside buildSuggestions is $query'.log();

    if (query.isEmpty) {
      if (searchQueryParameterPassed.isNotEmpty) {
        areaSearchBloc.add(GetUsersSearchEvent(
          receiveCountryId: receiveCountryId,
          serviceId: serviceId,
          searchQuery: searchQueryParameterPassed,
        ));

        return BlocBuilder<UserSearchBloc, UserSearchState>(
          builder: (context, state) {
            //
            'state is ${state.status}'.log();
            //
            Widget widget = const SizedBox.shrink();

            if (state.status == UserSearchStatus.loading) {
              widget = Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }

            if (state.status == UserSearchStatus.error) {
              widget = Center(
                child: Text(state.message),
              );
            }
            if (state.status == UserSearchStatus.success) {
              widget = ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) => UserSearchItem(
                  onTap: () {
                    selectedUser = state.users[index];

                    // close Search Delegate
                    close(context, selectedUser.id ?? 0);
                  },
                  title: '${state.users[index].name}',
                ),
              );
            }

            'widget is ${widget.runtimeType}'.log();
            return widget;
          },
        );
      } else {
        return const SizedBox.shrink();
      }
    } else {
      // making received search query empty
      searchQueryParameterPassed = "";

      // add event to search
      areaSearchBloc.add(GetUsersSearchEvent(
        receiveCountryId: receiveCountryId,
        serviceId: serviceId,
        searchQuery: query,
      ));

      'searchQueryParameterPassed is $searchQueryParameterPassed'.log();

      return BlocBuilder<UserSearchBloc, UserSearchState>(
        builder: (context, state) {
          //
          'state is ${state.status}'.log();
          //
          Widget widget = const SizedBox.shrink();

          if (state.status == UserSearchStatus.loading) {
            widget = Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          if (state.status == UserSearchStatus.error) {
            widget = Center(
              child: Text(state.message),
            );
          }
          if (state.status == UserSearchStatus.success) {
            widget = ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) => UserSearchItem(
                onTap: () {
                  selectedUser = state.users[index];

                  // close Search Delegate
                  close(context, selectedUser.id ?? 0);
                },
                title: '${state.users[index].name}',
              ),
            );
          }

          'widget is ${widget.runtimeType}'.log();
          return widget;
        },
      );
    }
  }
}
