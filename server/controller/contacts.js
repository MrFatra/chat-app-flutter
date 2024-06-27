import { User } from '../models/user.js'

export const onGetContact = async (req, res) => {
    try {
        const user = req.user
        const { name: contactName } = req.params

        let contacts
        if (!contactName) {
            contacts = await User.find({ _id: { $ne: user._id } }).select('-password')
        } else {
            const regexContact = new RegExp(contactName, 'i')
            contacts = await User.find({
                id: { $ne: user._id },
                $or: [
                    { fullName: { $regex: regexContact } },
                    { username: { $regex: regexContact } },
                ]
            }).select('-password')
        }

        if (!contacts) throw new Error('No contacts.')
        return res.status(200).json({ message: 'Contacts found!', data: contacts, status: 200 })
    } catch (error) {
        console.error(error)
        return res.status(401).json({ message: 'Failed to get contacts.', status: 401 })
    }
}