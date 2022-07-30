import Foundation

struct Task : Codable {
    var id: Int?
    var uuid: String
    var urgency: Int?
    var status: Status = Status.unknown
    var project: String?
    var description: String
    var _reminderId: String?
    
    func isCompleted() -> Bool { status == .completed }
    mutating func link(id: String) { _reminderId = id }
}

public enum Status : String, Codable {
    case deleted = "deleted"
    case pending = "pending"
    case started = "started"
    case completed = "completed"
    case unknown = "unknown"
}
