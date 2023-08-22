

gantt.attachEvent("onBeforeTaskChanged", function (id, mode, old_event) {
  var task = gantt.getTask(id);
  if (mode == gantt.config.drag_mode.progress) {
    if (task.progress < old_event.progress) {
      console.log("간트 차트 onBeforeTaskChanged" + task.text);
      return false;
    }
  }
  return true;
});




function convertToCustomFormat(dateString) {
  const months = {
    "1월": "01",
    "2월": "02",
    "3월": "03",
    "4월": "04",
    "5월": "05",
    "6월": "06",
    "7월": "07",
    "8월": "08",
    "9월": "09",
    "10월": "10",
    "11월": "11",
    "12월": "12"
  };

  const [time, monthDay] = dateString.split(", ");
  const [month, day] = monthDay.split(" ");
  const monthNumber = months[month];

  const year = new Date().getFullYear();

  return `${year}${monthNumber}${day.padStart(2, "0")}`;
}

