import Foundation

public protocol CommentsStorage: class {
    func comments(completion: Closure.Argument<[Comment]>?)
    
    func saveComments(_: [Comment])
    func removeComment(commentId: String, completion: Closure.Empty?)
}

final public class CommentsStorageInMemory: CommentsStorage {
    private let serialQueue = DispatchQueue(label: "SerialQueue.CommentsStorage")
    
    // MARK: - State
    private var comments = [Comment]()
    
    // MARK: - CommentsStorage
    public func comments(completion: Closure.Argument<[Comment]>?) {
        serialQueue.async { [weak self] in
            DispatchQueue.main.async {
                completion?(self?.comments ?? [])
            }
        }
    }
    
    public func saveComments(_ comments: [Comment]) {
        serialQueue.async { [weak self] in
            self?.comments = comments
        }
    }
    
    public func removeComment(commentId: String, completion: Closure.Empty?) {
        serialQueue.async { [weak self] in
            self?.comments = self?.comments.filter { $0.id != commentId } ?? []            
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
}
