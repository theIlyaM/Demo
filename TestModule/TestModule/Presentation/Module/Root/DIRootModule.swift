import Dip

class DIRootModule: DIModuleProtocol {
    func configure(container: DependencyContainer) {
        container.register { RootAssemblyImpl(feedAssembly: try! container.resolve() as FeedAssembly) as RootAssembly}
        container.register { RootRouterImpl(feedAssembly: try! container.resolve() as FeedAssembly, topViewControllerProvider: TopViewControllerProviderImpl() as TopViewControllerProvider) as RootRouter }
        container.register { DeepLinkHandlerImpl(rootRouter: try! container.resolve()) as DeepLinkHandler }
        container.register { PushNotificationHandlerImpl(deepLinkHandler: try! container.resolve()) as PushNotificationHandler }
        //Example of instaniating objective-c class
        container.register{ TestObjectiveClass(title: "Some title") }
    }
}
