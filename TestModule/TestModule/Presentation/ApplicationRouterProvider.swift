import UIKit

public protocol ApplicationRouterProvider: class {
    var rootRouter: RootRouter? { get }
}

final public class ApplicationRouterProviderImpl: ApplicationRouterProvider {
    // MARK: - Private properties
    private let moduleFactory: ModuleFactory
    private let topViewControllerProvider: TopViewControllerProvider
    
    // MARK: - Init
    public init(moduleFactory: ModuleFactory, topViewControllerProvider: TopViewControllerProvider) {
        self.moduleFactory = moduleFactory
        self.topViewControllerProvider = topViewControllerProvider
    }
    
    // MARK: - FeedRouter
    public var rootRouter: RootRouter? {
        return RootRouterImpl(
            rootViewController: topViewControllerProvider.topViewController(),
            moduleFactory: moduleFactory
        )
    }
}
