import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/privacy_policy_screen/bloc/privacy_bloc.dart';
import 'package:anexpress/features/privacy_policy_screen/view/components/privacy_policy_type_select_button.dart';
import 'package:anexpress/features/privacy_policy_screen/data/privacy_terms_conditions_model.dart';
import 'package:anexpress/widgets/overlay_animated_spinner.dart';
import 'package:flutter/material.dart';

import 'package:anexpress/exports/common_export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWalletAppBar(titleText: Loc.alized.msg_terms_and_privacy),
      body: SafeArea(
        child: BlocBuilder<PrivacyBloc, PrivacyState>(
          builder: (context, state) {
            if (state is PrivacyLoading) {
              return const OverLayAnimatedSpinner();
            }
            if (state is PrivacyLoaded) {
              return PrivacyPolicyChildWidget(privacyTermsModel: state.privacy);
            }

            if (state is PrivacyError) {
              return Center(child: Text(state.errorMessage));
            }

            return Container();
          },
        ),
      ),
    );
  }
}

class PrivacyPolicyChildWidget extends StatefulWidget {
  const PrivacyPolicyChildWidget({super.key, required this.privacyTermsModel});

  final PrivacyTermsModel privacyTermsModel;

  @override
  State<PrivacyPolicyChildWidget> createState() =>
      _PrivacyPolicyChildWidgetState();
}

class _PrivacyPolicyChildWidgetState extends State<PrivacyPolicyChildWidget>
    with SingleTickerProviderStateMixin {
  List<String> optionsList = const ["privacy", "terms"];
  int selectedTitleOption = 0;

  late TabController _tabController;
  int currentTabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() async {
      setState(
        () {
          currentTabIndex = _tabController.index;
          selectedTitleOption = _tabController.index;
        },
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 120,
            padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
            color: isLightMode()
                ? AppColors.secondary.withOpacity(0.1)
                : Theme.of(context).dividerColor,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                PrivacyPolicyTypeSelectButton(
                  title: "Privacy\nPolicy",
                  isSelected: currentTabIndex == 0 ? true : false,
                  onTap: () {
                    setState(() {
                      currentTabIndex = 0;
                    });
                    _tabController.animateTo(0);
                  },
                ),
                PrivacyPolicyTypeSelectButton(
                  title: "User\nT&C",
                  isSelected: currentTabIndex == 1 ? true : false,
                  onTap: () {
                    setState(() {
                      currentTabIndex = 1;
                    });
                    _tabController.animateTo(1);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 220,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  Padding(
                    padding: getPadding(all: 12),
                    child: HtmlWidget(
                      widget.privacyTermsModel.privacyPolicy?.description
                              ?.description ??
                          "",
                      renderMode: RenderMode.listView,
                    ),
                  ),
                  Padding(
                    padding: getPadding(all: 12),
                    child: HtmlWidget(
                      widget.privacyTermsModel.termsConditions?.description
                              ?.description ??
                          "",
                      renderMode: RenderMode.listView,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
