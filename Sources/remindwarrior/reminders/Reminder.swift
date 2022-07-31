import EventKit
import Foundation

extension EKReminder {
  func sync(_ from: Task) -> EKReminder {
    title = from.description
    isCompleted = from.isCompleted()
    setDueDate(from.due)
    return self
  }

  private func setDueDate(_ d: Date?) {
    guard d != nil else {
      return
    }

    let components = Calendar.current
      .dateComponents(in: TimeZone.current, from: d!)

    dueDateComponents = components
    addAlarm(EKAlarm(relativeOffset: -30 * 60))     // before 30 minutes
    addAlarm(EKAlarm(relativeOffset: -2 * 60 * 60)) // before 120 minutes
  }
}
