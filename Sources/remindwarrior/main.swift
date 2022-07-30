import AppKit
import EventKit
import Foundation

let store = EKEventStore()
do {
    try await store.requestAccess(to: .reminder)
} catch {
    exit(64)
}

let encoder = JSONEncoder()
let decoder = JSONDecoder()
let reminders = Reminders(store)

if let input = readLine(strippingNewline: true),
   let data = input.data(using: .utf8),
   var task = try? decoder.decode(Task.self, from: data) {
    task.link(id: reminders.createOrUpdate(task))
    print(String(data: try! encoder.encode(task), encoding: .utf8)!)
    exit(0)
} else {
    print("Malformed input")
    exit(1)
}
