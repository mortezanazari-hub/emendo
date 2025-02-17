class AppImages {
  static const String basePath = "assets/images/";

  static const String getStartScreen = "${basePath}get_start_screen.png";
  static const String logo = "${basePath}logo.png";
  static const String miniLogo = "${basePath}mini_logo.png";
  static const String nextButtonIntro = "${basePath}next_button_intro.svg";

  static String introScreenSlide(int index) {
    return "assets/images/intro_screen_slide${index.toString()}.png";
  }
}
