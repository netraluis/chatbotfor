'use client'
import { useUserSession } from '@/hooks/use-user-session'

export default function AppHome() {
  const { user, isLoading } = useUserSession()

  if (isLoading) return <div>Cargando...</div>
  if (!user) return <div>No autorizado</div>

  return (
    <div>
      <h1>Bienvenido, {user.email}</h1>
      {/* Tu contenido aquí */}
    </div>
  )
} 