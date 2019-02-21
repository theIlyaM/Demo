import Foundation

final public class Comment {
    // MARK: - Public properties
    public let id: String
    public let title: String
    
    // MARK: - Init
    public init(id: String, title: String) {
        self.id = id
        self.title = title
    }
}
