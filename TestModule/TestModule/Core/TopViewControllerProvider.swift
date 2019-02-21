import UIKit

public protocol TopViewControllerProvider {
    func topViewController() -> UIViewController?
}

final public class TopViewControllerProviderImpl: TopViewControllerProvider {
    // MARK: - TopViewControllerProvider
    public func topViewController() -> UIViewController? {
        var rootViewController = UIApplication.shared.windows.first?.rootViewController
        while ((rootViewController?.presentedViewController) != nil) {
            rootViewController = rootViewController?.presentedViewController
        }
        return rootViewController
    }
}
