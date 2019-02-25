import Dip

class DIFeedModule: DIModuleProtocol {
    func configure(container: DependencyContainer) {
        container.register { FeedServiceImpl() as FeedService }
        
        container.register { FeedAssemblyImpl(feedService: try! container.resolve(),
                                              commentsAssembly: try! container.resolve() as CommentsAssembly) as FeedAssembly }
    }
}
