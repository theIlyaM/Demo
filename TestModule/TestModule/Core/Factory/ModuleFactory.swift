import Foundation

public protocol ModuleFactory {
    func rootAssembly() -> RootAssembly
    func feedAssembly() -> FeedAssembly
    func commentsAssembly() -> CommentsAssembly
}

final public class ModuleFactoryImpl: ModuleFactory {
    // MARK: - Private properties
    private let serviceFactory: ServiceFactory
    
    // MARK: - Init
    public init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    // MARK: - ModuleFactory
    public func rootAssembly() -> RootAssembly {
        return RootAssemblyImpl(
            serviceFactory: serviceFactory,
            moduleFactory: self
        )
    }
    
    public func feedAssembly() -> FeedAssembly {
        return FeedAssemblyImpl(
            serviceFactory: serviceFactory,
            moduleFactory: self
        )
    }
    
    public func commentsAssembly() -> CommentsAssembly {
        return CommentsAssemblyImpl(
            serviceFactory: serviceFactory,
            moduleFactory: self
        )
    }
    
}
