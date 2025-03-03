class Assets {
  static const String basePath = "assets/images/";
  static const String getStartScreen = "${basePath}get_start_screen.png";
  static const String logo = "${basePath}logo.png";
  static const String miniLogo = "${basePath}mini_logo.png";
  static const String nextButtonIntro = "${basePath}next_button_intro.svg";
  static const String backButtonDark = "${basePath}back_button_dark.svg";
  static const String authCirclesView = "${basePath}auth_circles_view.svg";
  static const String googleLogo = "${basePath}google_logo.svg";
  static const String notificationTab = "${basePath}notification_tab.svg";
  static const String folderTab = "${basePath}folder_tab.svg";
  static const String homeTab = "${basePath}home_tab.svg";
  static const String profileTab = "${basePath}profile_tab.svg";
  static String introScreenSlide(int index) {
    return "assets/images/intro_screen_slide${index.toString()}.png";
  }
}
