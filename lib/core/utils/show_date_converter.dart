mixin DateConverter{
  String formatDate(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    // هنا بنرجّع التاريخ بالشكل اللي بدك إياه: يوم - شهر - سنة وساعة بنظام 12 ساعة
    return "${dateTime.day.toString().padLeft(2, '0')}-"
        "${dateTime.month.toString().padLeft(2, '0')}-"
        "${dateTime.year} "
        "${dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12}:"
        "${dateTime.minute.toString().padLeft(2, '0')} "
        "${dateTime.hour >= 12 ? 'PM' : 'AM'}";
  }
}