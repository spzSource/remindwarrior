import EventKit
import Foundation

extension EKEventStore {
  public func syncReminder(_ from: Task) -> String {
    let reminder = from._reminderId != nil
      ? get(from._reminderId!) ?? draft()
      : draft()

    try! self.save(reminder.sync(from), commit: true)

    return reminder.calendarItemIdentifier
  }

  private func get(_ id: String) -> EKReminder? {
    calendarItem(withIdentifier: id) as! EKReminder?
  }

  private func draft() -> EKReminder {
    let reminder = EKReminder(eventStore: self)
    let defaultCalendar = defaultCalendarForNewReminders()!
    reminder.calendar = defaultCalendar
    return reminder
  }
}
