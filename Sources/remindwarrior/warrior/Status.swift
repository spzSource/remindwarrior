import Foundation

public enum Status: String, Codable {
  case deleted = "deleted"
  case pending = "pending"
  case started = "started"
  case completed = "completed"
  case unknown = "unknown"
}