extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() == 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if ((difference.inDays / 7).floor() > 1) {
      return '${(difference.inDays / 7).floor()} week ago';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  String timeAgoStory() {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 1) {
      return '${(difference.inDays / 7).floor()} w';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} d';
    } else if (difference.inDays >= 1) {
      return '1 d';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} h';
    } else if (difference.inHours >= 1) {
      return '1 h';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} m';
    } else if (difference.inMinutes >= 1) {
      return '1 m';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} s';
    } else {
      return 'Just now';
    }
  }
}



// String getVerboseDateTimeRepresentation(DateTime dateTime) {
//     DateTime now = DateTime.now().toLocal();

//     DateTime localDateTime = dateTime.toLocal();

//     if (localDateTime.difference(now).inDays == 0) {
//       var differenceInHours = localDateTime.difference(now).inHours.abs();
//       var differenceInMins = localDateTime.difference(now).inMinutes.abs();

//       if (differenceInHours > 0) {
//         return '$differenceInHours hours ago';
//       } else if (differenceInMins > 2) {
//         return '$differenceInMins mins ago';
//       } else {
//         return 'Just now';
//       }
//     }

//     String roughTimeString = DateFormat('jm').format(dateTime);

//     if (localDateTime.day == now.day &&
//         localDateTime.month == now.month &&
//         localDateTime.year == now.year) {
//       return roughTimeString;
//     }

//     DateTime yesterday = now.subtract(const Duration(days: 1));

//     if (localDateTime.day == yesterday.day &&
//         localDateTime.month == now.month &&
//         localDateTime.year == now.year) {
//       return 'Yesterday';
//     }

//     if (now.difference(localDateTime).inDays < 4) {
//       String weekday = DateFormat(
//         'EEEE',
//       ).format(localDateTime);

//       return '$weekday, $roughTimeString';
//     }

//     return '${DateFormat('yMd').format(dateTime)}, $roughTimeString';
//   }