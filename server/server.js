import express from 'express';
import { METHODS, createServer } from 'http';
import { Server } from 'socket.io';
import { mongoConfig } from './cluster/config.js';
import 'dotenv/config'

export const app = express();
export const server = createServer(app);
export const io = new Server(server, {
    cors: {
        origin: "*",
        methods: ['GET', 'POST']
    }
});

mongoConfig()

const usersSocketMap = {}

export const getReceiverSocketId = (receiverId) => {
    return usersSocketMap[receiverId]
}

io.on('connection', (socket) => {
    const userId = socket.handshake.query.userId
    if (userId != 'undefined') usersSocketMap[userId] = socket.id
    console.log(`A user has connected: ${socket.id}`)
    io.emit('online users', Object.keys(usersSocketMap))


    // socket.on('new message', (message) => {
    //     console.log(`new message on id: ${socket.id}`)
    //     console.log('Message ' + message)
    //     io.emit('new message', message)
    // });

    socket.on('disconnect', () => {
        delete usersSocketMap[userId]
        io.emit('online users', Object.keys(usersSocketMap))
        console.log(`A user has disconnected: ${userId}`)
    });
});

server.listen(process.env.SOCKET_PORT, () => {
    console.log('Socket Listening on *:', process.env.SOCKET_PORT)
});
