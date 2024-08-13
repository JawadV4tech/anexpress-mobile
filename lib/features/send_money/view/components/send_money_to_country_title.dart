import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/send_money/bloc/send_money_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendMoneyToCountryTitle extends StatelessWidget {
  const SendMoneyToCountryTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMoneyBloc, SendMoneyState>(
      builder: (context, state) {
        return Padding(
          padding: getPadding(left: 2, top: 20),
          child: Text24SemiBold(
              "SEND MONEY TO ${state.sendToCountryInfo.name?.toUpperCase()}"),
        );
      },
    );
  }
}
