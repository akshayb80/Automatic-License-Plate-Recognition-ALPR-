

class Task {
  List<Task> tasks;
  String note;
  DateTime timetoComplete;
  bool completed;
  String repeats;
  DateTime deadline;
  List<DateTime> reminders;
  String taskID;
  String title;

  Task(this.title, this.completed, this.taskID);
}