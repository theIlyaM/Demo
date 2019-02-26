import Foundation
import Dip

protocol DIModuleProtocol {
    func configure(container: DependencyContainer)
}

class DIContainer {
    private static var dependencyContainer: DependencyContainer?
    
    public static func container() -> DependencyContainer {
        if DIContainer.dependencyContainer == nil {
            let container = DependencyContainer()
            for assembly in DIContainer.getAssemblies() {
                assembly.configure(container: container)
            }
            try! container.bootstrap()
            DIContainer.dependencyContainer = container
            DependencyContainer.uiContainers = [container]
        }
        return DIContainer.dependencyContainer!
    }
    
    static func getAssemblies() -> [DIModuleProtocol] {
        return [
            DIRootModule(),
            DIFeedModule(),
            DICommentModule()
            //...Сюда можно добавлять отдельные module-определения с сервисами...
        ] + DIContainer.getModules()
    }
    
    static func getModules() -> [DIModuleProtocol] {
        return [
            //...Сюда можно добавлять отдельные module-определения с assembly...
            //...Пока решил не разделять их, а класть и сервисы, и assembly в одно место...
        ]
    }
}
