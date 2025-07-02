'use client'
import { useState } from 'react'
import { createSupabaseBrowserClient } from '@/lib/supabase-client'

export default function LoginPage() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)
  const supabase = createSupabaseBrowserClient()

  async function handleLogin(e: React.FormEvent) {
    e.preventDefault()
    setLoading(true)
    setError('')
    const { error } = await supabase.auth.signInWithPassword({ email, password })
    if (error) setError(error.message)
    setLoading(false)
  }

  async function handleOAuth(provider: 'google' | 'github') {
    setLoading(true)
    setError('')
    const { error } = await supabase.auth.signInWithOAuth({ provider })
    if (error) setError(error.message)
    setLoading(false)
  }

  return (
    <div>
      <h1>Login</h1>
    </div>
  )
  //   <div style={{ maxWidth: 320, margin: 'auto', padding: 32 }}>
  //     <form onSubmit={handleLogin}>
  //       <input
  //         type="email"
  //         placeholder="Email"
  //         value={email}
  //         onChange={e => setEmail(e.target.value)}
  //         required
  //         style={{ width: '100%', marginBottom: 8 }}
  //       />
  //       <input
  //         type="password"
  //         placeholder="Password"
  //         value={password}
  //         onChange={e => setPassword(e.target.value)}
  //         required
  //         style={{ width: '100%', marginBottom: 8 }}
  //       />
  //       <button type="submit" disabled={loading} style={{ width: '100%' }}>
  //         {loading ? 'Logging in...' : 'Log In'}
  //       </button>
  //     </form>
  //     <div style={{ margin: '16px 0', textAlign: 'center' }}>or</div>
  //     <button onClick={() => handleOAuth('google')} style={{ width: '100%', marginBottom: 8 }}>
  //       Continue with Google
  //     </button>
  //     <button onClick={() => handleOAuth('github')} style={{ width: '100%' }}>
  //       Continue with GitHub
  //     </button>
  //     {error && <div style={{ color: 'red', marginTop: 16 }}>{error}</div>}
  //   </div>
  // )
}
