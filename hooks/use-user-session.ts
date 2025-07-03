'use client'
import { useEffect, useState } from 'react'
import { createSupabaseBrowserClient } from '@/lib/supabase-client'
import type { User } from '@supabase/supabase-js'

export function useUserSession() {
  const [user, setUser] = useState<User | null>(null)
  const [isLoading, setIsLoading] = useState(true)
  const supabase = createSupabaseBrowserClient()

  useEffect(() => {
    let ignore = false
    supabase.auth.getUser().then(({ data }) => {
      if (!ignore) {
        setUser(data.user)
        setIsLoading(false)
      }
    })
    return () => { ignore = true }
  }, [supabase])

  return { user, isLoading }
} 