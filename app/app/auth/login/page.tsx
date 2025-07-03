'use client'
import ConfirmationScreen from '@/components/card/confirmation-card'
import { useState } from 'react'
import { createSupabaseBrowserClient } from '@/lib/supabase-client'
import { CircleUser } from 'lucide-react'

export default function LoginPage() {
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const supabase = createSupabaseBrowserClient()

  async function handleGoogleLogin() {
    setLoading(true)
    setError('')
    const { error } = await supabase.auth.signInWithOAuth({ provider: 'google' })
    if (error) setError(error.message)
    setLoading(false)
  }

  return (
    <ConfirmationScreen
      title="Inicia sesión con Google"
      description="Accede a tu cuenta usando Google. No necesitas usuario ni contraseña."
      buttonText="Entrar con Google"
      logo={CircleUser}
      onButtonClick={handleGoogleLogin}
      loading={loading}
      linkText={error && <span className="text-red-500">{error}</span>}
    />
  )
}
