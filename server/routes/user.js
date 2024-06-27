import { Router } from 'express'
import { authMiddleware } from '../middleware/auth.js'
import { onSendMessage, onGetMessages } from '../controller/message.js'
import { onGetContact } from '../controller/contacts.js'

const router = Router()

router.use(authMiddleware)

router.post('/message/send/:id', onSendMessage)
router.get('/chats/:id', onGetMessages)
router.get('/contacts', onGetContact)
router.get('/contacts/:name', onGetContact)

export default router