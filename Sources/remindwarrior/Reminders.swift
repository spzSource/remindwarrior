//
//  Remenders.swift
//  Created by Popitich Aleksandr on 24.07.22.
//

import EventKit
import Foundation


class Reminders {
    private let store: EKEventStore
    
    public init(_ store: EKEventStore) {
        self.store = store
    }
    
    func createOrUpdate(_ task: Task) -> String {
        let reminder = task._reminderId != nil
        ? get(task._reminderId!) ?? draft()
        : draft()
        
        reminder.title = task.description
        reminder.isCompleted = task.isCompleted()
        
        try! self.store.save(reminder, commit: true)
        
        return reminder.calendarItemIdentifier
    }
    
    private func get(_ id: String) -> EKReminder? {
        self.store.calendarItem(withIdentifier: id) as! EKReminder?
    }
    
    private func draft() -> EKReminder {
        let reminder = EKReminder(eventStore: self.store)
        let defaultCalendar = self.store.defaultCalendarForNewReminders()!
        reminder.calendar = defaultCalendar
        return reminder
    }
}
