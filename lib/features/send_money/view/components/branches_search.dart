import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/branches_feature/data/bank_branch_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BranchesSearch extends SearchDelegate<BankBranchInfoModel> {
  final List<BankBranchInfoModel> branchesList;

  late BankBranchInfoModel selectedBranch;

  BranchesSearch(
    this.branchesList,
  ) : super(
          searchFieldLabel: 'Search Branch',
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
        close(context, const BankBranchInfoModel());
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
              '${selectedBranch.name}',
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

    // if query is not empty show empty widget other wise build areas list base on BlocProvider
    if (query.isEmpty) {
      return ListView.builder(
        itemCount: branchesList.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(color: AppColors.gray5001),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          child: ListTile(
            onTap: () {
              selectedBranch = branchesList[index];
              close(context, selectedBranch);
            },
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.secondary,
            ),
            title: Text(
              branchesList[index].name ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    } else {
      final suggestionList = query.isEmpty
          ? branchesList
          : branchesList
              .where((p) => p.name!.toLowerCase().contains(query.toLowerCase()))
              .toList();

      return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(color: AppColors.gray5001),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          child: ListTile(
            onTap: () {
              selectedBranch = suggestionList[index];
              close(context, suggestionList[index]);
            },
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.secondary,
            ),
            title: RichText(
              text: TextSpan(
                children: List.generate(
                  suggestionList[index].name!.length,
                  (charIndex) {
                    final char = suggestionList[index].name![charIndex];
                    final isQueryMatch = charIndex < query.length
                        ? char.toLowerCase() == query[charIndex].toLowerCase()
                        : false;

                    return TextSpan(
                      text: char,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isQueryMatch
                            ? AppColors.secondary
                            : Colors.grey.shade900,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
