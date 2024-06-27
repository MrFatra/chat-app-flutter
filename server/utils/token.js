import jwt from 'jsonwebtoken'

export const signCookieToken = (userId, res) => {
    try {
        const token = jwt.sign({ userId }, process.env.JWT_TOKEN_KEY, {
            expiresIn: '2d',
        })
        if (!token) throw new Error('Token couldn\'t be generated.')

        res.cookie('user', token, {
            maxAge: 15 * 24 * 60 * 60 * 1000,
            httpOnly: true,
            sameSite: 'strict',
            secure: process.env.NODE_ENV !== 'development'
        })
        return token
    } catch (err) {
        console.error(err.message)
    }
}