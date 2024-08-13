import 'package:anexpress/core/values/local_files.dart';

class FinTechService {
  final String serviceName;
  final String serviceIcon;

  FinTechService({
    required this.serviceName,
    required this.serviceIcon,
  });
}

List<FinTechService> finTechServicesList = [
  FinTechService(
    serviceName: "Quick Pay",
    serviceIcon: LocalFiles.imgGridGray600,
  ),
  FinTechService(
    serviceName: "Pay Connect",
    serviceIcon: LocalFiles.imgUseralt,
  ),
  FinTechService(
    serviceName: "Discover Merchants",
    serviceIcon: LocalFiles.imgBag,
  ),
  FinTechService(
    serviceName: "Bills",
    serviceIcon: LocalFiles.bills,
  ),
  FinTechService(
    serviceName: "Top Up",
    serviceIcon: LocalFiles.topUpBalance,
  ),
  FinTechService(
    serviceName: "Gift Envelope",
    serviceIcon: LocalFiles.gifts,
  ),
  FinTechService(
    serviceName: "Mobile Top-Up",
    serviceIcon: LocalFiles.payPhone,
  ),
  FinTechService(
    serviceName: "Utilities",
    serviceIcon: LocalFiles.utilities,
  ),
  FinTechService(
    serviceName: "Education",
    serviceIcon: LocalFiles.education,
  ),
  FinTechService(
    serviceName: "Donations",
    serviceIcon: LocalFiles.donations,
  ),
  FinTechService(
    serviceName: "Online Store",
    serviceIcon: LocalFiles.imgBag,
  ),
  FinTechService(
    serviceName: "Gift Envelope",
    serviceIcon: LocalFiles.gifts,
  ),
];
