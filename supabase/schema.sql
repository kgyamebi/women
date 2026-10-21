-- EVA AI health records.
-- Apply in the Supabase SQL editor. Enable anonymous sign-in
-- only if you intend to use the demo auth path.
-- Personal health state lives in one encrypted-in-transit document
-- per user. Community posts are the only shared table.

create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  payload jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.profiles enable row level security;

create policy "read own profile"
  on public.profiles for select
  using (auth.uid() = id);

create policy "insert own profile"
  on public.profiles for insert
  with check (auth.uid() = id);

create policy "update own profile"
  on public.profiles for update
  using (auth.uid() = id)
  with check (auth.uid() = id);

create policy "delete own profile"
  on public.profiles for delete
  using (auth.uid() = id);

create table if not exists public.community_posts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  space text not null check (char_length(space) between 1 and 40),
  author text not null check (char_length(author) between 1 and 40),
  body text not null check (char_length(body) between 1 and 500),
  verified boolean not null default false,
  created_at timestamptz not null default now()
);

alter table public.community_posts enable row level security;

create policy "read community"
  on public.community_posts for select
  to authenticated
  using (true);

create policy "write own community post"
  on public.community_posts for insert
  to authenticated
  with check (auth.uid() = user_id);

create policy "delete own community post"
  on public.community_posts for delete
  to authenticated
  using (auth.uid() = user_id);

-- Production scale path: project daily logs out of payload into a
-- partitioned daily_logs table once analytics need SQL filters.
-- Mixpanel receives product events, never raw symptom text.
-- Firebase delivers the same two whispers the app already shows.
-- Wearables enter through HealthKit and Health Connect, then land
-- as samples the brief can read. This demo can preview a night
-- without those bridges.
