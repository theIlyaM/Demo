import UIKit

public protocol FeedRouter: Router {
    func showComments(memeId: String, onModuleSetUp: Closure.Argument<CommentsModule>?)
}

final public class FeedRouterImpl: BaseRouter, FeedRouter {
    let commentsAssembly: CommentsAssembly
    
    init(commentsAssembly: CommentsAssembly, rootViewController: UIViewController?) {
        self.commentsAssembly = commentsAssembly
        super.init(rootViewController: rootViewController)
    }
    
    // MARK: - FeedRouter
    public func showComments(
        memeId: String,
        onModuleSetUp: Closure.Argument<CommentsModule>?)
    {
        let commentsModule = commentsAssembly.createComments(memeId: memeId)
        
        onModuleSetUp?(commentsModule.interface)

        open(commentsModule.view)
    }
}
