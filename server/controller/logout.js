export const onLogout = (req, res) => {
    try {
        res.clearCookie('user', {
            maxAge: 0,
            httpOnly: true,
            sameSite: 'strict',
            secure: process.env.NODE_ENV !== 'development',
        })
        return res.status(200).json({ message: 'Succesfully logged out.', status: 200 })
    } catch (error) {
        return res.status(401).json({ message: 'Log out failed.', status: 401 })
    }
}