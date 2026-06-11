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

-- 初始示例数据
insert into students (name, exam_id, school, scores) values
  ('张伟', '3301022024010015', '浙江省杭州第一中学',
   '{"语文":88,"数学":95,"英语":92,"物理":85,"化学":89,"生物":90,"历史":94,"地理":87,"思想政治":91}'),
  ('李明', '3301022024010023', '浙江省杭州第二中学',
   '{"语文":76,"数学":83,"英语":79,"物理":91,"化学":86,"生物":72,"历史":80,"地理":88,"思想政治":77}'),
  ('王芳', '3301022024010031', '浙江省宁波效实中学',
   '{"语文":94,"数学":88,"英语":96,"物理":78,"化学":82,"生物":91,"历史":87,"地理":90,"思想政治":93}')
on conflict (exam_id) do nothing;
