import mongoose, { Schema } from "mongoose";

const MessageModel = mongoose.Schema({
    senderId: { type: Schema.Types.ObjectId, ref: 'users', required: true },
    receiverId: { type: Schema.Types.ObjectId, ref: 'users', required: true },
    message: { type: String, required: true },
    isRead: { type: Boolean, default: false },
    createdAt: { type: Date, default: Date.now }
}, { timestamps: true })

export const Message = mongoose.model('messages', MessageModel)