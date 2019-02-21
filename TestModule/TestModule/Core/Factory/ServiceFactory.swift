import Foundation

final public class ServiceFactory {
    // MARK: - Private properties
    private let commentsStorageInstance = CommentsStorageInMemory()
    
    // MARK: - Public
    public func feedService() -> FeedService {
        return FeedServiceImpl()
    }
    
    public func commentsService() -> CommentsService {
        return CommentsServiceImpl(
            commentsStorage: commentsStorageInstance
        )
    }
}
