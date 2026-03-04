-- Debug helpers for user role issues
-- Run these in the Supabase SQL editor (or via psql) to inspect and fix user role rows.

-- 1) Inspect the user row (replace the UUID)
-- SELECT * FROM public.users WHERE id = 'ab9471e1-beab-424e-89d8-2a02d7114b55';

-- 2) Inspect the corresponding auth.users entry
-- SELECT id, email, raw_user_meta FROM auth.users WHERE id = 'ab9471e1-beab-424e-89d8-2a02d7114b55';

-- 3) Use the RPC to upsert the role (preferred)
-- SELECT public.insert_user_role('ab9471e1-beab-424e-89d8-2a02d7114b55'::uuid, 'admin'::public.user_role);

-- 4) Or update the role directly
-- UPDATE public.users
-- SET role = 'admin'
-- WHERE id = 'ab9471e1-beab-424e-89d8-2a02d7114b55';

-- 5) Bulk-add any missing auth users as members (idempotent)
-- INSERT INTO public.users (id, role)
-- SELECT id, 'member'::public.user_role
-- FROM auth.users au
-- WHERE NOT EXISTS (SELECT 1 FROM public.users pu WHERE pu.id = au.id);

-- 6) Quick check to ensure at least one admin exists
-- SELECT id, role, created_at FROM public.users WHERE role = 'admin' ORDER BY created_at ASC LIMIT 5;

-- 7) If you prefer to delete a problematic users row before re-inserting (use carefully)
-- DELETE FROM public.users WHERE id = 'ab9471e1-beab-424e-89d8-2a02d7114b55';

-- Notes:
-- - Use the RPC `public.insert_user_role` when possible; it is defined WITH SECURITY DEFINER
--   and will work when invoked by the service role.
-- - If `SELECT * FROM public.users` returns a row but the API still returns "No user role found",
--   the likely cause is that the API is not using a service role key, or RLS is preventing reads.
--   Confirm `SUPABASE_SERVICE_ROLE_KEY` in `apps/api/.env` and restart the API.
