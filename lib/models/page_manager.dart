import 'package:flutter/material.dart';

class PageManager {
  PageManager(this._pageController);

  final PageController _pageController;

  int currentPage = 0;

  void setPage(int value) {
    if (value == currentPage) return;
    currentPage = value;
    _pageController.jumpToPage(value);
  }
}
