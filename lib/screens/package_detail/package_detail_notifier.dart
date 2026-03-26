import 'package:intl/intl.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';

class PackageDetailNotifier extends BaseChangeNotifier {
  int? packageId;

  PackageDetailNotifier(this.packageId) {
    loadPackageDetail();
  }

  bool isLoading = true;
  Map<String, dynamic>? packageDetail;

  final List<Map<String, dynamic>> deliveries = [
    {
      "title": "Package Received",
      "lockerSize": "Medium",
      "receiver": "Abdul Rahman",
      "deliveredAt": "2026-03-10 14:46:00",
      "statusAt": "2026-03-10 20:00:00",
      "statusLabel": "Active",
      "referenceId": "DLV-10234",
      "deliveredBy": "*****3214",
      "pickupCode": "PK4821",
      "qrValue": "DLV-10234|PK4821|ACTIVE",
    },
    {
      "title": "Package Received",
      "lockerSize": "Large",
      "receiver": "Abdul Rahman",
      "deliveredAt": "2026-03-09 13:20:00",
      "statusAt": "2026-03-10 21:00:00",
      "statusLabel": "Overdue",
      "referenceId": "DLV-10235",
      "deliveredBy": "*****8741",
      "pickupCode": "PK1936",
      "qrValue": "DLV-10235|PK1936|OVERDUE",
    },
    {
      "title": "Package Collected",
      "lockerSize": "Small",
      "receiver": "Abdul Rahman",
      "deliveredAt": "2026-03-10 09:00:00",
      "statusAt": "2026-03-10 11:10:00",
      "statusLabel": "Used",
      "referenceId": "DLV-10228",
      "deliveredBy": "*****9921",
      "pickupCode": "PK7782",
      "qrValue": "DLV-10228|PK7782|USED",
    },
    {
      "title": "Delivery Expired",
      "lockerSize": "Medium",
      "receiver": "Abdul Rahman",
      "deliveredAt": "2026-03-08 14:46:00",
      "statusAt": "2026-03-09 22:00:00",
      "statusLabel": "Expired",
      "referenceId": "DLV-10220",
      "deliveredBy": "*****4408",
      "pickupCode": "PK5540",
      "qrValue": "DLV-10220|PK5540|EXPIRED",
    },
  ];

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "--";

    try {
      final parsed = DateTime.parse(date);
      return DateFormat('dd-MM-yyyy, hh:mm a').format(parsed);
    } catch (_) {
      return "--";
    }
  }

  void loadPackageDetail() {
    isLoading = true;
    notifyListeners();

    try {
      packageDetail = deliveries.firstWhere(
            (item) => item["referenceId"] == packageId,
      );
    } catch (_) {
      packageDetail = null;
    }

    isLoading = false;
    notifyListeners();
  }

  String get status => packageDetail?["statusLabel"] ?? "";
  String get title => packageDetail?["title"] ?? "--";
  String get referenceId => packageDetail?["referenceId"] ?? "--";
  String get deliveredAt => packageDetail?["deliveredAt"] ?? "--";
  String get statusAt => packageDetail?["statusAt"] ?? "--";
  String get lockerSize => packageDetail?["lockerSize"] ?? "--";
  String get receiver => packageDetail?["receiver"] ?? "--";
  String get deliveredBy => packageDetail?["deliveredBy"] ?? "--";
  String get pickupCode => packageDetail?["pickupCode"] ?? "--";
  String get qrValue => packageDetail?["qrValue"] ?? "--";

  bool get isOverdue => status.toLowerCase() == "overdue";
  bool get isUsed => status.toLowerCase() == "used";
  bool get isExpired => status.toLowerCase() == "expired";
  bool get isActive => status.toLowerCase() == "active";

  String get secondLabel {
    if (isActive) return "Pickup Before";
    if (isOverdue) return "Overdue Since";
    if (isUsed) return "Collected On";
    return "Expired On";
  }
}