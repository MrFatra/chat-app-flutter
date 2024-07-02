import { User } from "../models/user.js"
import bcrypt from 'bcrypt'
import { createAvatar } from '@dicebear/core'
import * as bottts from '@dicebear/bottts-neutral'

export const onRegister = async (req, res) => {
    try {
        const { fullName, username, password, gender } = await handleRequest(req.body)

        const salt = await bcrypt.genSalt(10)
        const hashedPass = await bcrypt.hash(password, salt)

        const avatar = await createAvatar(bottts, { seed: username }).toJson()['svg'].toString()

        const newUser = await User.create({ fullName, username, avatar, password: hashedPass, gender })
        return res.status(200).json({ message: 'Success creating user', status: 200, user: newUser })
    }
    catch (err) {
        console.log(`ERR Regist: ${err.message}`);
        res.status(401).json({ message: err.message, status: 401 })
    }
}

const handleRequest = async (requests) => {
    const { fullName, username, password, confirmPassword, gender } = requests;
    const userExist = await User.findOne({ username })
    if (!fullName || !username || !password || !confirmPassword || !gender) throw new Error('All fields is required.')
    if (userExist) throw new Error('Username has been taken.')
    if (username.length < 6) throw new Error('Username must be over 6 characters.')
    if (password !== confirmPassword) throw new Error('Password doesn\'t match.')

    return { fullName, username, password, gender }
}