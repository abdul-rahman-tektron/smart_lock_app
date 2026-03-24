import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';
import 'package:smart_lock_app/res/colors.dart';

class PackageHistoryNotifier extends BaseChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  final ScrollController horizontalScrollController = ScrollController();

  final List<String> statusOptions = [
    "All",
    "Active",
    "Overdue",
    "Used",
    "Expired",
  ];

  final List<String> boxSizeOptions = [
    "All",
    "Small",
    "Medium",
    "Large",
  ];

  String? selectedStatus = "All";
  String? selectedBoxSize = "All";

  int currentPage = 1;
  final int pageSize = 10;

  final List<PackageHistoryItem> _allPackages = [
    PackageHistoryItem(
      title: "Package Received",
      lockerSize: "Medium",
      receiver: "Abdul Rahman",
      deliveredAt: "2026-03-10 14:46:00",
      statusAt: "2026-03-10 20:00:00",
      status: "Active",
      referenceId: "DLV-10234",
      deliveredBy: "*****3214",
    ),
    PackageHistoryItem(
      title: "Package Received",
      lockerSize: "Large",
      receiver: "Abdul Rahman",
      deliveredAt: "2026-03-09 13:20:00",
      statusAt: "2026-03-10 21:00:00",
      status: "Overdue",
      referenceId: "DLV-10235",
      deliveredBy: "*****8741",
    ),
    PackageHistoryItem(
      title: "Package Collected",
      lockerSize: "Small",
      receiver: "Abdul Rahman",
      deliveredAt: "2026-03-10 09:00:00",
      statusAt: "2026-03-10 11:10:00",
      status: "Used",
      referenceId: "DLV-10228",
      deliveredBy: "*****9921",
    ),
    PackageHistoryItem(
      title: "Delivery Expired",
      lockerSize: "Medium",
      receiver: "Abdul Rahman",
      deliveredAt: "2026-03-08 14:46:00",
      statusAt: "2026-03-09 22:00:00",
      status: "Expired",
      referenceId: "DLV-10220",
      deliveredBy: "*****4408",
    ),
    PackageHistoryItem(
      title: "Package Received",
      lockerSize: "Large",
      receiver: "Abdul Rahman",
      deliveredAt: "2026-03-07 12:15:00",
      statusAt: "2026-03-07 19:00:00",
      status: "Used",
      referenceId: "DLV-10210",
      deliveredBy: "*****1245",
    ),
    PackageHistoryItem(
      title: "Package Received",
      lockerSize: "Small",
      receiver: "Abdul Rahman",
      deliveredAt: "2026-03-06 08:05:00",
      statusAt: "2026-03-06 18:00:00",
      status: "Expired",
      referenceId: "DLV-10208",
      deliveredBy: "*****9987",
    ),
  ];

  List<PackageHistoryItem> filteredPackages = [];

  PackageHistoryNotifier() {
    filteredPackages = List.from(_allPackages);
  }

  int get totalPages {
    if (filteredPackages.isEmpty) return 1;
    return (filteredPackages.length / pageSize).ceil();
  }

  List<PackageHistoryItem> get currentPageItems {
    if (filteredPackages.isEmpty) return [];

    final start = (currentPage - 1) * pageSize;
    int end = start + pageSize;

    if (start >= filteredPackages.length) return [];
    if (end > filteredPackages.length) end = filteredPackages.length;

    return filteredPackages.sublist(start, end);
  }

  int get activeCount =>
      _allPackages.where((e) => e.status == "Active").length;

  int get overdueCount =>
      _allPackages.where((e) => e.status == "Overdue").length;

  int get usedCount =>
      _allPackages.where((e) => e.status == "Used").length;

  int get expiredCount =>
      _allPackages.where((e) => e.status == "Expired").length;

  void onSearchChanged(String value) {
    applyFilters();
  }

  void updateStatus(String? value) {
    selectedStatus = value;
    notifyListeners();
  }

  void updateBoxSize(String? value) {
    selectedBoxSize = value;
    notifyListeners();
  }

  Future<void> pickFromDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 30)),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      fromDateController.text = DateFormat('dd-MM-yyyy').format(picked);
      notifyListeners();
    }
  }

  Future<void> pickToDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      toDateController.text = DateFormat('dd-MM-yyyy').format(picked);
      notifyListeners();
    }
  }

  void applyFilters() {
    final search = searchController.text.trim().toLowerCase();

    DateTime? fromDate;
    DateTime? toDate;

    try {
      if (fromDateController.text.trim().isNotEmpty) {
        fromDate = DateFormat('dd-MM-yyyy').parse(fromDateController.text.trim());
      }
    } catch (_) {}

    try {
      if (toDateController.text.trim().isNotEmpty) {
        toDate = DateFormat('dd-MM-yyyy').parse(toDateController.text.trim());
      }
    } catch (_) {}

    filteredPackages = _allPackages.where((item) {
      final deliveredDate = DateTime.tryParse(item.deliveredAt);

      final matchesSearch = search.isEmpty ||
          item.referenceId.toLowerCase().contains(search);

      final matchesStatus = selectedStatus == null ||
          selectedStatus == "All" ||
          item.status == selectedStatus;

      final matchesBoxSize = selectedBoxSize == null ||
          selectedBoxSize == "All" ||
          item.lockerSize == selectedBoxSize;

      final matchesFromDate = fromDate == null ||
          (deliveredDate != null &&
              !deliveredDate.isBefore(
                DateTime(fromDate.year, fromDate.month, fromDate.day),
              ));

      final matchesToDate = toDate == null ||
          (deliveredDate != null &&
              !deliveredDate.isAfter(
                DateTime(toDate.year, toDate.month, toDate.day, 23, 59, 59),
              ));

      return matchesSearch &&
          matchesStatus &&
          matchesBoxSize &&
          matchesFromDate &&
          matchesToDate;
    }).toList();

    currentPage = 1;
    notifyListeners();
  }

  void clearFilters() {
    searchController.clear();
    fromDateController.clear();
    toDateController.clear();
    selectedStatus = "All";
    selectedBoxSize = "All";
    filteredPackages = List.from(_allPackages);
    currentPage = 1;
    notifyListeners();
  }

  void goToPreviousPage() {
    if (currentPage > 1) {
      currentPage--;
      notifyListeners();
    }
  }

  void goToNextPage() {
    if (currentPage < totalPages) {
      currentPage++;
      notifyListeners();
    }
  }

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "--";

    try {
      final parsed = DateTime.parse(date);
      return DateFormat('dd-MM-yyyy, hh:mm a').format(parsed);
    } catch (_) {
      return "--";
    }
  }

  String timelineLabel(PackageHistoryItem item) {
    final formatted = formatDate(item.statusAt);

    switch (item.status.toLowerCase()) {
      case "active":
        return "Pickup before $formatted";
      case "overdue":
        return "Overdue since $formatted";
      case "used":
        return "Collected on $formatted";
      case "expired":
        return "Expired on $formatted";
      default:
        return formatted;
    }
  }

  Color timelineColor(PackageHistoryItem item) {
    switch (item.status.toLowerCase()) {
      case "overdue":
        return Colors.orange;
      case "expired":
        return Colors.red;
      case "used":
        return AppColors.textSecondary;
      default:
        return AppColors.primary;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    horizontalScrollController.dispose();
    super.dispose();
  }
}

class PackageHistoryItem {
  final String title;
  final String lockerSize;
  final String receiver;
  final String deliveredAt;
  final String statusAt;
  final String status;
  final String referenceId;
  final String deliveredBy;

  PackageHistoryItem({
    required this.title,
    required this.lockerSize,
    required this.receiver,
    required this.deliveredAt,
    required this.statusAt,
    required this.status,
    required this.referenceId,
    required this.deliveredBy,
  });
}