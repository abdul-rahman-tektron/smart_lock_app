import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_lock_app/res/fonts.dart';

class CustomDropdown<T> extends StatelessWidget {
  // Data
  final List<T> items;
  final T? value;

  // Text
  final String title;
  final TextStyle? titleStyle;
  final String hintText;
  final String Function(T) itemLabel;

  // Dynamic padding
  final EdgeInsetsGeometry? contentPadding;

// Hint styling
  final TextStyle? hintStyleOverride;

// Optional: popup search hint style
  final TextStyle? searchHintStyle;

  // Behavior
  final ValueChanged<T?>? onChanged;
  final bool enabled;

  // UI
  final bool showTitle;
  final bool required;
  final String? toolTipContent;

  final bool showSearch;
  final bool showClearButton;
  final TextInputType? textInputType;

  // Expand like CustomTextField
  final bool expand;

  // Popup settings
  final double popupMaxHeight;
  final int searchDebounceMs;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.title,
    required this.hintText,
    required this.itemLabel,
    this.value,
    this.titleStyle,
    this.onChanged,
    this.enabled = true,
    this.showTitle = true,
    this.required = false,
    this.toolTipContent,
    this.showSearch = true,
    this.showClearButton = true,
    this.expand = true,
    this.popupMaxHeight = 150,
    this.searchDebounceMs = 250,
    this.contentPadding,
    this.hintStyleOverride,
    this.searchHintStyle,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    final selected = _resolveSelected(value);

    // ✅ MATCH CustomTextField
    final labelStyle = titleStyle ?? AppFonts.text6.bold.style.copyWith(
      color: Colors.black.withOpacity(0.75),
      letterSpacing: 0.2,
    );

    final fieldTextStyle = AppFonts.text6.regular.style.copyWith(
      color: Colors.black.withOpacity(0.85),
    );

    final hintStyle = hintStyleOverride ??
        AppFonts.text6.regular.style.copyWith(
          color: Colors.black.withOpacity(0.4),
        );


    final fillColor = enabled ? Colors.white.withOpacity(0.22) : Colors.black.withOpacity(0.05);

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.r),
      borderSide: BorderSide(color: Colors.black.withOpacity(0.18), width: 1),
    );

    final focused = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.r),
      borderSide: BorderSide(color: Colors.blueAccent.withOpacity(0.8), width: 1.4),
    );

    final widgetTree = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showTitle && title.isNotEmpty) ...[
          Row(
            children: [
              Text(title, style: labelStyle),
              if (required) ...[
                4.horizontalSpace,
                Text("*", style: labelStyle.copyWith(color: Colors.red.withOpacity(0.85))),
              ],
              if (toolTipContent != null) ...[
                6.horizontalSpace,
                Tooltip(
                  message: toolTipContent!,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: AppFonts.text6.regular.style.copyWith(color: Colors.white),
                  child: Icon(Icons.info_outline, size: 16, color: Colors.black.withOpacity(0.55)),
                ),
              ],
            ],
          ),
          6.verticalSpace, // ✅ same spacing as CustomTextField
        ],

        RepaintBoundary(
          child: DropdownSearch<T>(
            selectedItem: selected,
            enabled: enabled,
            onChanged: onChanged,

            items: (String filter, LoadProps? _) => _filteredItems(filter),
            itemAsString: (T item) => itemLabel(item),
            compareFn: (a, b) => identical(a, b) || itemLabel(a) == itemLabel(b),

            // ✅ Input decoration matches CustomTextField exactly
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: fillColor,

                // This gives same “height feel” as your textfield
                contentPadding: contentPadding ??
                    EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.h),
                // hintText: hintText,
                // hintStyle: hintStyle,
                border: border,
                enabledBorder: border,
                focusedBorder: focused,

                errorBorder: border.copyWith(
                  borderSide: BorderSide(color: Colors.red.withOpacity(0.85), width: 1.2),
                ),
                focusedErrorBorder: border.copyWith(
                  borderSide: BorderSide(color: Colors.red.withOpacity(0.85), width: 1.2),
                ),
                errorStyle: AppFonts.text6.regular.style.copyWith(
                  color: Colors.red.withOpacity(0.9),
                ),

                // ✅ match your suffix icon constraints
                suffixIconConstraints: BoxConstraints(maxHeight: 20.sp, maxWidth: 30.sp),
              ),
            ),

            // ✅ keep selected text style same as TextField text
            dropdownBuilder: (context, selectedItem) {
              final text = selectedItem == null ? "" : itemLabel(selectedItem);
              return Text(
                text.isEmpty ? hintText : text,
                style: text.isEmpty ? hintStyle : fieldTextStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            },

            popupProps: PopupProps.menu(
              showSearchBox: showSearch,
              searchDelay: Duration(milliseconds: searchDebounceMs),

              // ✅ Force fixed popup height here (works even when MenuProps has no constraints)
              containerBuilder: (ctx, popupWidget) =>
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    clipBehavior: Clip.antiAlias,
                    child: SizedBox(
                      height: popupMaxHeight.h, // ✅ fixed height
                      child: popupWidget, // ✅ list will scroll inside
                    ),
                  ),

              // ✅ ensure list scrolls (don’t shrinkWrap)
              listViewProps: const ListViewProps(
                shrinkWrap: false,
                padding: EdgeInsets.zero,
              ),

              searchFieldProps: TextFieldProps(
                style: fieldTextStyle,
                keyboardType: textInputType ?? TextInputType.text,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Search…",
                  hintStyle: hintStyle,
                  contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.h),
                  border: border,
                  enabledBorder: border,
                  focusedBorder: focused,
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              itemBuilder: (context, item, isSelected, isDisabled) {
                final text = itemLabel(item);
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          text,
                          style: AppFonts.text6.regular.style.copyWith(
                            color: isDisabled ? Colors.black38 : Colors.black.withOpacity(0.85),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isSelected)
                        Icon(Icons.check, size: 18, color: Colors.blueAccent.withOpacity(0.8)),
                    ],
                  ),
                );
              },
            ),

            suffixProps: DropdownSuffixProps(
              dropdownButtonProps: DropdownButtonProps(
                iconClosed: Icon(Icons.keyboard_arrow_down_rounded, size: 10.sp),
                iconOpened: Icon(Icons.keyboard_arrow_up_rounded, size: 10.sp),
              ),
            ),
          ),
        ),
      ],
    );

    return expand ? Expanded(child: widgetTree) : widgetTree;
  }

  FutureOr<List<T>> _filteredItems(String filter) {
    final f = filter.trim().toLowerCase();
    if (f.isEmpty) return items;
    return items.where((e) => itemLabel(e).toLowerCase().contains(f)).toList();
  }

  T? _resolveSelected(T? initial) {
    if (initial == null) return null;
    if (items.contains(initial)) return initial;

    final needle = itemLabel(initial);
    for (final it in items) {
      if (itemLabel(it) == needle) return it;
    }
    return null;
  }
}
