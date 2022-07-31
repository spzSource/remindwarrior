import AppKit
import EventKit
import Foundation

let store = EKEventStore()
do {
  try await store.requestAccess(to: .reminder)
} catch {
  exit(64)
}

let iso8601Short = DateFormatter()
iso8601Short.dateFormat = "yyyyMMdd'T'HHmmss'Z'"

let (encoder, decoder) = (JSONEncoder(), JSONDecoder())

decoder.dateDecodingStrategy = .formatted(iso8601Short)
encoder.dateEncodingStrategy = .formatted(iso8601Short)

guard
  let input = readLine(strippingNewline: true),
  let data = input.data(using: .utf8),
  let originTask = try? decoder.decode(Task.self, from: data)
else {
  print("Malformed input")
  exit(1)
}

let reminderId = store.syncReminder(originTask)
let linkedTask = originTask.link(id: reminderId)
print(String(data: try encoder.encode(linkedTask), encoding: .utf8)!)
print("Task added to Reminders.")
exit(0)
