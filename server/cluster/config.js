import bodyParser from 'body-parser'
import cors from 'cors'
import express from 'express'
import cookieParser from 'cookie-parser'
import { mongoConnect } from './connect.js'
import authRoutes from '../routes/auth.js'
import userRoutes from '../routes/user.js'
import { app } from '../server.js'

export const mongoConfig = async () => {
    app.use(express.json())
    app.use(express.urlencoded({ extended: true }))
    app.use(bodyParser.json())
    app.use(cors())
    app.use(cookieParser())

    mongoConnect()
    
    app.use('/api/auth', authRoutes)
    app.use('/api/user', userRoutes)
}