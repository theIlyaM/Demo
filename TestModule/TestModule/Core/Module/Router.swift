import UIKit

public protocol Router {
    func close(animated: Bool, completion: Closure.Empty?)
}

public extension Router {
    func close() {
        close(animated: true, completion: nil)
    }
}

public enum RouterPresentationStyle {
    case push
    case modal
//    case custom(Animator)
}

public class BaseRouter {
    // MARK: - Private properties
    private weak var rootViewController: UIViewController?
    
    // MARK: - Init
    public init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    // MARK: - Public
    public func open(
        _ viewController: UIViewController,
        presentationStyle: RouterPresentationStyle = .push,
        animated: Bool = true,
        completion: Closure.Empty? = nil)
    {
        switch presentationStyle {
        case .push:
            rootViewController?.show(viewController, sender: self)
        case .modal:
            rootViewController?.present(viewController, animated: animated, completion: completion)
        }
        
    }
    
    // MARK: - Router
    public func close(animated: Bool, completion: Closure.Empty?) {
        let isModal = rootViewController?.isModal ?? false
        let shouldDismiss = rootViewController?.navigationController?.viewControllers.count == 1
        
        if isModal && shouldDismiss {
            rootViewController?.navigationController?.dismiss(animated: true, completion: completion)
        } else {
            rootViewController?.navigationController?.popViewController(animated: true)
            completion?()
        }
    }
}
