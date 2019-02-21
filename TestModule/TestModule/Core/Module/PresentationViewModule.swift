import UIKit

final public class PresentationViewModule<Module> {
    // MARK: - Public properties
    public let interface: Module
    public let view: UIViewController
    
    // MARK: - Init
    public init(interface: Module, view: UIViewController) {
        self.interface = interface
        self.view = view
    }
}
