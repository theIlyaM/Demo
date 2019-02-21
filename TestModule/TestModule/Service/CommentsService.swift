import Foundation

public protocol CommentsService: class {
    func loadComments(memeId: String, completion: Closure.Argument<[Comment]>?)
    func removeComment(commentId: String, completion: Closure.Empty?)
}

final public class CommentsServiceImpl: CommentsService {
    // MARK: - Private properties
    private let commentsStorage: CommentsStorage
    
    // MARK: - Init
    public init(commentsStorage: CommentsStorage) {
        self.commentsStorage = commentsStorage
    }
    
    // MARK: - CommentsService
    public func loadComments(memeId: String, completion: Closure.Argument<[Comment]>?) {
        commentsStorage.comments { comments in
            if comments.isEmpty {
                // Simulate loading from server
                DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
                    DispatchQueue.main.async { [weak self] in
                        let comments = self?.generateMockSerializedAnswer() ?? []
                        
                        self?.commentsStorage.saveComments(comments)
                        
                        completion?(comments)
                    }
                }
            } else {
                completion?(comments)
            }
        }

    }
    
    public func removeComment(commentId: String, completion: Closure.Empty?) {
        commentsStorage.removeComment(commentId: commentId, completion: completion)
    }
    
    // MARK: - Private
    private func generateMockSerializedAnswer() -> [Comment] {
        return [
            Comment(id: "1", title: "Комментарий 1"),
            Comment(id: "2", title: "Комментарий 2"),
            Comment(id: "3", title: "Комментарий 3"),
            Comment(id: "4", title: "Комментарий 4"),
            Comment(id: "5", title: "Ебать ты лох")
        ]
    }
}
