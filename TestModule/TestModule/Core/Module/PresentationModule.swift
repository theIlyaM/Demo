import UIKit

final public class PresentationModule<Module> {
    // MARK: - Public properties
    public let interface: Module
    
    // MARK: - Init
    public init(interface: Module) {
        self.interface = interface
    }
}
