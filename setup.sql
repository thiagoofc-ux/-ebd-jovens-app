-- Tabela de jovens
create table if not exists youths (
  id uuid default gen_random_uuid() primary key,
  name text unique not null,
  total_points integer default 0,
  created_at timestamptz default now()
);

-- Tabela de ações configuráveis
create table if not exists actions (
  id text primary key,
  name text not null,
  icon text not null,
  points integer default 5,
  sort_order integer default 0
);

-- Tabela de histórico
create table if not exists history (
  id uuid default gen_random_uuid() primary key,
  youth_name text not null,
  action_id text not null,
  action_name text not null,
  action_icon text not null,
  points integer not null,
  created_at timestamptz default now()
);

-- Inserir ações padrão
insert into actions (id, name, icon, points, sort_order) values
  ('presenca',     'Presença',     '🙋', 5,  0),
  ('participacao', 'Participação', '✋', 5,  1),
  ('biblia',       'Bíblia',       '📖', 5,  2),
  ('caderno',      'Caderno',      '📓', 5,  3),
  ('pergunta',     'Pergunta',     '❓', 5,  4),
  ('visitante',    'Visitante',    '👤', 10, 5),
  ('oferta',       'Oferta',       '💚', 3,  6)
on conflict (id) do nothing;

-- Inserir jovens padrão
insert into youths (name) values
  ('Alif'), ('Bruno'), ('Carla'), ('Daniel'),
  ('Érica'), ('Felipe'), ('Gabi'), ('Hugo')
on conflict (name) do nothing;

-- Habilitar acesso público (RLS off para uso simples)
alter table youths  disable row level security;
alter table actions disable row level security;
alter table history disable row level security;
