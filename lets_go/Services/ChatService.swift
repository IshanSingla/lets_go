

import Foundation

enum ChatError: Error {
    case currentUserNotFound
    case chatNotFound
    case userNotFound
    case messageCreationFailed
}

class ChatService {
    private let chatRepository: ChatRepository
    private let messageRepository: MessageRepository
    private let userRepository: UserRepository
    private let authService: AuthService
    
    init(chatRepository: ChatRepository = ChatRepository(),
         messageRepository: MessageRepository = MessageRepository(),
         userRepository: UserRepository = UserRepository()) {
        self.chatRepository = chatRepository
        self.messageRepository = messageRepository
        self.userRepository = userRepository
        authService = AuthService()
    }
    
    // Function to get all chats for the current user
    func getAllChatsForCurrentUser() throws -> [Chat] {
        do{
            let currentUser = try authService.getCurrentUser()

        
        var chatsForCurrentUser = chatRepository.findAll().filter { $0.userIds.contains(currentUser.id) }
        chatsForCurrentUser = chatsForCurrentUser.map { chat in
            var modifiedChat = chat
            let userIds = chat.userIds
            if let anotherUserId = userIds.first(where: { $0 != currentUser.id }),
               let anotherUser = userRepository.findOne(byId: anotherUserId) {
                modifiedChat.anotherUser = anotherUser
            }
            return modifiedChat
        }
        
        return chatsForCurrentUser
        }
        catch{
            throw ChatError.currentUserNotFound
        }
    }
    func getAllMessages(for chatId: String) throws -> [Message] {
        guard let chat = chatRepository.findOne(byId: chatId) else {
            throw ChatError.chatNotFound
        }
        
        return messageRepository.findAll().filter { $0.chatId == chat.id }
    }
    
    // Function to create a message in a particular chat
    func createMessage(inChat chatId: String, withMessage message: String) throws-> Message {
        guard let currentUser = UserDefaults.standard.object(forKey: "userId") as? String else {
            throw ChatError.currentUserNotFound
        }
        
        guard let chat = chatRepository.findOne(byId: chatId) else {
            throw ChatError.chatNotFound
        }
        
        guard chat.userIds.contains(currentUser) else {
            throw ChatError.chatNotFound
        }
        let newMessage = Message(chatId: chatId, userId: currentUser, message: message)
        messageRepository.create(message: newMessage)
        return newMessage
    }
}
