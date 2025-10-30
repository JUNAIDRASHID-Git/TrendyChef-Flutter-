import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/main.dart';

class LanguageSelector extends StatefulWidget {
  final String currentLanguage;

  const LanguageSelector({super.key, this.currentLanguage = 'en'});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late String _selectedLang;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isExpanded = false;

  final List<LanguageOption> _languages = const [
    LanguageOption(code: 'en', name: 'English', nativeName: 'English'),
    LanguageOption(code: 'ar', name: 'Arabic', nativeName: 'العربية'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedLang = widget.currentLanguage;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isExpanded) {
      _removeOverlay();
      _animationController.reverse();
    } else {
      _showOverlay();
      _animationController.forward();
    }
    setState(() => _isExpanded = !_isExpanded);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    final screenWidth = MediaQuery.of(context).size.width;
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    const dropdownWidth = 150.0;
    const padding = 16.0;

    double left;
    if (isRTL) {
      left = offset.dx + size.width - dropdownWidth;
      if (left < padding) left = padding;
    } else {
      left = offset.dx;
      if (left + dropdownWidth > screenWidth - padding) {
        left = screenWidth - dropdownWidth - padding;
      }
    }

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            left: left,
            top: offset.dy + size.height + 8,
            width: dropdownWidth,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                      _languages.map((lang) {
                        final isSelected = lang.code == _selectedLang;
                        return InkWell(
                          onTap: () {
                            _selectLanguage(lang.code);
                            _toggleDropdown();
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? AppColors.primary.withOpacity(0.1)
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        lang.nativeName,
                                        style: TextStyle(
                                          fontWeight:
                                              isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        lang.name,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    Icons.check_circle,
                                    color: AppColors.primary,
                                    size: 18,
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _selectLanguage(String langCode) {
    setState(() => _selectedLang = langCode);
    MyApp.setLocale(context, Locale(langCode));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isExpanded ? AppColors.primary : Colors.grey.shade300,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.language, color: AppColors.fontWhite, size: 25),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageOption {
  final String code;
  final String name;
  final String nativeName;

  const LanguageOption({
    required this.code,
    required this.name,
    required this.nativeName,
  });
}
