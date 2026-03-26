import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';
import 'package:smart_lock_app/core/model/error_response.dart';
import 'package:smart_lock_app/core/model/package/package_list_response.dart';
import 'package:smart_lock_app/core/remote/services/common_repository.dart';
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

  bool isLoading = false;
  String errorMessage = "";

  int currentPage = 1;
  final int pageSize = 10;

  List<PackageListDataItem> allPackages = [];
  List<PackageListDataItem> filteredPackages = [];

  PackageHistoryNotifier() {
    loadPackageHistory();
  }

  Future<void> loadPackageHistory() async {
    isLoading = true;
    errorMessage = "";
    notifyListeners();

    try {
      getSavedUser();
      final receiverId = user?.tenantId?.toString();

      final result = await CommonRepository.instance.apiPackageList(
        receiverId: receiverId,
        pageNumber: 1,
        pageSize: 500,
      );

      if (result is PackageListResponse && result.success == true) {
        allPackages = result.data?.items ?? [];
        filteredPackages = List.from(allPackages);
      } else if (result is PackageListResponse) {
        errorMessage = result.message ?? "Failed to load package history";
      } else if (result is ErrorResponse) {
        errorMessage = result.message ?? "Failed to load package history";
      } else {
        errorMessage = "Failed to load package history";
      }
    } catch (_) {
      errorMessage = "Something went wrong";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  int get totalPages {
    if (filteredPackages.isEmpty) return 1;
    return (filteredPackages.length / pageSize).ceil();
  }

  List<PackageListDataItem> get currentPageItems {
    if (filteredPackages.isEmpty) return [];

    final start = (currentPage - 1) * pageSize;
    int end = start + pageSize;

    if (start >= filteredPackages.length) return [];
    if (end > filteredPackages.length) end = filteredPackages.length;

    return filteredPackages.sublist(start, end);
  }

  int get activeCount =>
      allPackages.where((e) => (e.statusId ?? 0) == 1).length;

  int get overdueCount =>
      allPackages.where((e) => (e.statusId ?? 0) == 2).length;

  int get usedCount =>
      allPackages.where((e) => (e.statusId ?? 0) == 3).length;

  int get expiredCount =>
      allPackages.where((e) => (e.statusName ?? "").toLowerCase() == "expired").length;

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

    filteredPackages = allPackages.where((item) {
      final deliveredDate = item.createdOn;

      final packageId = (item.lockerDetailId?.toString() ?? "").toLowerCase();

      final matchesSearch = search.isEmpty || packageId.contains(search);

      final itemStatus = getStatusLabel(item);
      final matchesStatus = selectedStatus == null ||
          selectedStatus == "All" ||
          itemStatus == selectedStatus;

      final itemBoxSize = getBoxSizeLabel(item);
      final matchesBoxSize = selectedBoxSize == null ||
          selectedBoxSize == "All" ||
          itemBoxSize == selectedBoxSize;

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
    filteredPackages = List.from(allPackages);
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

  String formatDate(DateTime? date) {
    if (date == null) return "--";

    try {
      return DateFormat('dd-MM-yyyy, hh:mm a').format(date);
    } catch (_) {
      return "--";
    }
  }

  String getStatusLabel(PackageListDataItem item) {
    switch (item.statusId) {
      case 1:
        return "Active";
      case 2:
        return "Overdue";
      case 3:
        return "Used";
      default:
        final status = item.statusName?.trim();
        if (status == null || status.isEmpty) return "--";
        return status;
    }
  }

  String getBoxSizeLabel(PackageListDataItem item) {
    switch (item.lockerSizeId) {
      case 1:
        return "Small";
      case 2:
        return "Medium";
      case 3:
        return "Large";
      default:
        return "--";
    }
  }

  String getReceiverName(PackageListDataItem item) {
    return user?.fullName ?? "--";
  }

  String getDeliveredBy(PackageListDataItem item) {
    return item.deliveryAgentId?.toString() ?? "--";
  }

  String getReferenceId(PackageListDataItem item) {
    return item.lockerDetailId?.toString() ?? "--";
  }

  String timelineLabel(PackageListDataItem item) {
    final formatted = formatDate(item.verifiedOn is DateTime ? item.verifiedOn : item.createdOn);
    final status = getStatusLabel(item).toLowerCase();

    switch (status) {
      case "active":
        return "Pickup before \n$formatted";
      case "overdue":
        return "Overdue since \n$formatted";
      case "used":
        return "Collected on \n$formatted";
      case "expired":
        return "Expired on \n$formatted";
      default:
        return formatted;
    }
  }

  String deliveredOnLabel(PackageListDataItem item) {
    final formatted = formatDate(item.verifiedOn is DateTime ? item.verifiedOn : item.createdOn);
    return formatted;
  }

  Color timelineColor(PackageListDataItem item) {
    switch (getStatusLabel(item).toLowerCase()) {
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