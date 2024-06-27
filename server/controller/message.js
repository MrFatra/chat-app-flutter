import { Chat } from '../models/chat.js'
import { Message } from '../models/message.js'
import { getReceiverSocketId, io } from '../server.js'

export const onSendMessage = async (req, res) => {
    try {
        const senderId = req.user._id
        const { id: receiverId } = req.params
        const { message } = req.body

        let participants
        participants = await Chat.findOne({
            participants: { $all: [senderId, receiverId] }
        })

        if (!participants) {
            participants = await Chat.create({
                participants: [senderId, receiverId],
            })
        }

        const newMessage = await Message.create({
            senderId,
            receiverId,
            message,
        })

        if (!newMessage || !participants) throw new Error('Cannot send message, please try again.')

        participants.messages.push(message)

        Promise.all([participants.save(), newMessage.save()])

        const receiverSocketId = getReceiverSocketId(receiverId)
        if (receiverSocketId) {
            console.log('receiver socket id: ', receiverSocketId);
            io.to(receiverSocketId).emit('new message', newMessage)
        }

        console.log('socketid: ', receiverSocketId)
        return res.status(200).json({ message: 'Message sent.', newMessage, status: 200 })
    } catch (err) {
        console.error(err.message)
        return res.status(401).json({ message: err.message, status: 401 })
    }
}

export const onGetMessages = async (req, res) => {
    try {
        const senderId = req.user._id
        const { id: receiverId } = req.params

        const messages = await Message.find({ senderId, receiverId })
        return res.status(200).json({ message: 'Messages found!', messages })
    } catch (err) {
        console.error(err.message)
        return res.status(500).json({ message: err.message, messages: [] })
    }

}