import UIKit

public protocol RootRouter: Router {
    func showFeed(presentationStyle: RouterPresentationStyle)
}

final public class RootRouterImpl: BaseRouter, RootRouter {
    // MARK: - RootRouter
    public func showFeed(presentationStyle: RouterPresentationStyle) {
        let feedAssembly = moduleFactory.feedAssembly()
        let feedModule = feedAssembly.createFeed(
            settings: FeedViewControllerSettings(
                navigationItemStyle: navigationItemStyle(
                    presentationStyle: presentationStyle
                )
            )
        )
        
        let view: UIViewController
        
        switch presentationStyle {
        case .push:
            view = feedModule.view
        case .modal:
            view = UINavigationController(
                rootViewController: feedModule.view
            )
        }
        
        open(
            view,
            presentationStyle: presentationStyle
        )
    }
    
    // MARK: - Private
    private func navigationItemStyle(presentationStyle: RouterPresentationStyle) -> FeedViewControllerSettings.NavigationItemStyle {
        switch presentationStyle {
        case .push:
            return .none
        case .modal:
            return  .closeLeftButton
        }
    }
}
