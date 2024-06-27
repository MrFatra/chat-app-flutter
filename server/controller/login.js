import { User } from '../models/user.js'
import bcrypt from 'bcrypt'
import { signCookieToken } from '../utils/token.js'

export const onLogin = async (req, res) => {
    try {
        const { username, password } = handleRequest(req.body)
        const user = await User.findOne({ username })
        if (!user) throw new Error('Invalid username or password')
        const decryptPass = await bcrypt.compare(password, user.password)
        if (!decryptPass) throw new Error('Invalid username or password')
        const token = signCookieToken(user._id, res)
        return res.status(200).json({ success: true, user, message: `Authenticated as ${user.username}`, token })
    } catch (err) {
        return res.status(401).json({ message: err.message, status: 401 })
    }
}

const handleRequest = (request) => {
    const { username, password } = request
    if (!username || !password) throw new Error('All fields required.')
    return { username, password }
}