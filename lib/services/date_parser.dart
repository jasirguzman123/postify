class DateParser {

  static String parseDate(date) {
    int month = int.parse(date.split('/').first) - 1;
    String day = date.split('/')[1];
    String indicator;

    switch (day.split('').last) {
      case '1':
        indicator = 'st';
        break;
      case '2':
        indicator = 'nd';
        break;
      case '3':
        indicator = 'rd';
        break;
      default:
        indicator = 'th';
    }
    List months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return "${months[month]} ${day+indicator}";
  }

}