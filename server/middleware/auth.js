import jwt from "jsonwebtoken"
import { User } from "../models/user.js"

export const authMiddleware = async (req, res, next) => {
    try {
        const token = req.cookies.user
        if (!token) throw new Error('Unauthorized - User not logged in.')
        const decoded = jwt.verify(token, process.env.JWT_TOKEN_KEY)
        if (!decoded) throw new Error('Unauthorized - Invalid user.')
        const user = await User.findById(decoded.userId)
        if (!user) throw new Error('No user provided.')
        req.user = user
        next()
    } catch (err) {
        return res.status(401).json({ message: `Authorization error occured: ${err.message}` })
    }
}