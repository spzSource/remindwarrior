import Foundation

public struct Task: Codable {
  let id: Int?
  let uuid: String
  let due: Date?
  let urgency: Int?
  let status: Status
  let project: String?
  let description: String
  let _reminderId: String?

  func isCompleted() -> Bool {
    status == .completed
  }
}

extension Task {
  func link(id: String) -> Task {
    Task(
      id: self.id,
      uuid: uuid,
      due: due,
      urgency: urgency,
      status: status,
      project: project,
      description: description,
      _reminderId: id)
  }
}
