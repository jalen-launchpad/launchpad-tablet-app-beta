class ProgressBarModel {
  static String printDuration(double secondsToGo) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    var duration = Duration(seconds: secondsToGo.toInt());
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
