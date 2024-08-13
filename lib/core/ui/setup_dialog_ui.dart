import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/core/enums/dialog_type.dart';
import 'package:anexpress/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  var dialogService = locator<DialogService>();

  final builders = {
    DialogType.Basic: (context, sheetRequest, completer) =>
        _BasicDialog(request: sheetRequest, completer: completer),
    DialogType.Generic: (context, sheetRequest,
            Function(DialogResponse<GenericDialogResponse>) completer) =>
        _GenericDialog(
          request: sheetRequest,
          completer: completer,
        ),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

class _BasicDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _BasicDialog({Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.indigo20001,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.indigo20001,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              request.title ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              request.description ?? '',
              style: const TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => completer(DialogResponse()),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: request.showIconInMainButton ?? false
                    ? const Icon(Icons.check_circle)
                    : Text(request.mainButtonTitle ?? ''),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GenericDialogRequest {
  const GenericDialogRequest({
    this.message = 'Hello World',
  });

  final String message;
}

class GenericDialogResponse {
  const GenericDialogResponse({
    this.message = 'Hello World',
  });

  final String message;
}

class _GenericDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse<GenericDialogResponse>) completer;

  const _GenericDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteA700,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.whiteA700,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              request.title ?? 'Generic Dialog',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              request.description ?? '',
              style: const TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => completer(
                DialogResponse(data: const GenericDialogResponse()),
              ),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: 100,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: request.showIconInMainButton ?? false
                    ? const Icon(Icons.check_circle)
                    : Text(
                        request.mainButtonTitle ?? 'Ok',
                        style: TextStyle(color: AppColors.whiteA700),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
