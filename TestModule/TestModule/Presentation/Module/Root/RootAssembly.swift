import UIKit

public protocol RootAssembly: class {
    func create() -> ViewModule
}

final public class RootAssemblyImpl: RootAssembly {
    let feedAssembly: FeedAssembly
    
    init(feedAssembly: FeedAssembly) {
        self.feedAssembly = feedAssembly
    }
    
    public func create() -> ViewModule {
        let feedModule = feedAssembly.createFeed(
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
