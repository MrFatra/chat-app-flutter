import mongoose from 'mongoose'
import 'dotenv/config'

export const mongoConnect = () => {
    mongoose.connect(process.env.MONGODB_URL).then(() => {
        console.log('Database Connected!')
    }).catch((err) => {
        console.error(err.message)
    })
}