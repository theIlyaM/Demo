import Dip

class DICommentModule: DIModuleProtocol {
    func configure(container: DependencyContainer) {
        let commentsStorageInstance = CommentsStorageInMemory()
        container.register { CommentsServiceImpl(commentsStorage: commentsStorageInstance) as CommentsService }
        
        container.register { CommentsAssemblyImpl(commentService: try! container.resolve()) as CommentsAssembly }
    }
}
