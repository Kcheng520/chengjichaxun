-- 在 Supabase SQL Editor 中运行此文件

create table if not exists students (
  id          serial primary key,
  name        text not null,
  exam_id     text not null unique,
  school      text not null default '浙江省教育考试院',
  scores      jsonb not null default '{}',
  auto_generated boolean not null default false,
  generated_at   timestamptz,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

-- 索引：按姓名+准考证号查询
create index if not exists idx_students_name_exam on students(name, exam_id);

-- 初始示例数据（浙江省中考科目：语文/数学/英语/科学/社会/体育，总分660）
insert into students (name, exam_id, school, scores) values
  ('张伟', '3301022024010015', '浙江省杭州第一中学',
   '{"语文":112,"数学":118,"英语":115,"科学":148,"社会":92,"体育":39}'),
  ('李明', '3301022024010023', '浙江省杭州第二中学',
   '{"语文":98,"数学":86,"英语":90,"科学":126,"社会":78,"体育":33}'),
  ('王芳', '3301022024010031', '浙江省宁波效实中学',
   '{"语文":115,"数学":112,"英语":118,"科学":152,"社会":95,"体育":38}')
on conflict (exam_id) do nothing;
