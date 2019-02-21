import UIKit

public protocol AlertDisplayable {
    func showAlertWithTitle(_: String?, message: String?, actions:[UIAlertAction], completion:(() -> ())?)
}

public extension AlertDisplayable {
    public func showAlertWithTitle(_ title: String, message: String?, buttonTitle:String, onButtonTap: Closure.Empty?) {
        let action = UIAlertAction(title: buttonTitle, style: .default) { action in
            onButtonTap?()
        }
        
        showAlertWithTitle(title, message: message, actions: [action], completion: nil)
    }
    
    public func showAlertWithTitle(_ title: String, buttonTitle:String, onButtonTap: Closure.Empty?) {
        showAlertWithTitle(title, message: nil, buttonTitle: buttonTitle, onButtonTap: onButtonTap)
    }
}

public extension AlertDisplayable where Self: UIViewController {
    func showAlertWithTitle(_ title: String?, message: String?, actions:[UIAlertAction], completion:(() -> ())?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alertController.addAction($0) }
        
        present(alertController, animated: true, completion: completion)
    }
}
