import { Router } from "express";
import { onLogin } from '../controller/login.js'
import { onRegister } from '../controller/register.js'
import { onLogout } from '../controller/logout.js'

const router = Router()

router.post('/login', onLogin)
router.post('/register', onRegister)
router.post('/logout', onLogout)

export default router