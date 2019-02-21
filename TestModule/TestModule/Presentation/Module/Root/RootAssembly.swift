import UIKit

public protocol RootAssembly: class {
    func create() -> ViewModule
}

final public class RootAssemblyImpl: Assembly, RootAssembly {
    public func create() -> ViewModule {
        let feedModule = moduleFactory.feedAssembly().createFeed(
            settings: FeedViewControllerSettings(
                navigationItemStyle: .none
            )
        )
        
        let view = UINavigationController(
            rootViewController: feedModule.view
        )
        
        return ViewModule(
            view: view
        )
    }
}
