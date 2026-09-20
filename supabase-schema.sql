-- 在 Supabase Dashboard → SQL Editor 中执行一次。
create table if not exists public.paper_cards_profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{"folders":[]}'::jsonb,
  checkins jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.paper_cards_profiles enable row level security;

create policy "Users can read their own paper cards"
  on public.paper_cards_profiles for select
  using (auth.uid() = id);

create policy "Users can create their own paper cards"
  on public.paper_cards_profiles for insert
  with check (auth.uid() = id);

create policy "Users can update their own paper cards"
  on public.paper_cards_profiles for update
  using (auth.uid() = id)
  with check (auth.uid() = id);
