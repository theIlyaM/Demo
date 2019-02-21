import UIKit

public protocol FeedRouter: Router {
    func showComments(memeId: String, onModuleSetUp: Closure.Argument<CommentsModule>?)
}

final public class FeedRouterImpl: BaseRouter, FeedRouter {    
    // MARK: - FeedRouter
    public func showComments(
        memeId: String,
        onModuleSetUp: Closure.Argument<CommentsModule>?)
    {
        let commentsAssembly = moduleFactory.commentsAssembly()
        let commentsModule = commentsAssembly.createComments(memeId: memeId)
        
        onModuleSetUp?(commentsModule.interface)

        open(commentsModule.view)
    }
}
