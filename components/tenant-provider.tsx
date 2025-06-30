'use client';
import { TenantContext } from '../lib/tenant-context';

export default function TenantProvider({ tenant, children }: { tenant: string | null, children: React.ReactNode }) {
  return (
    <TenantContext.Provider value={tenant}>
      {children}
    </TenantContext.Provider>
  );
} 