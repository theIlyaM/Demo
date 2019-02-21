import Foundation

public class Assembly {
    // MARK: - Public properties
    public let serviceFactory: ServiceFactory
    public let moduleFactory: ModuleFactory
    
    // MARK: - Init
    public init(serviceFactory: ServiceFactory, moduleFactory: ModuleFactory) {
        self.serviceFactory = serviceFactory
        self.moduleFactory = moduleFactory
    }
}
