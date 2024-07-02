import mongoose, { Schema } from "mongoose";

const ChatModel = mongoose.Schema({
    participants: [{
        type: Schema.Types.ObjectId,
        ref: 'users',
        required: true,
    }],
    messages: [{
        type: Schema.Types.ObjectId,
        ref: 'messages',
        default: [],
    }]
})

export const Chat = mongoose.model('chats', ChatModel)