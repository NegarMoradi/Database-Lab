insert into skill_level_temp values ('eaa256c1-7bc5-4c8f-b1cb-4deceabc11cd', 'beginner');

-- 17-a)

select s.skill_name, sl.level
from "Freelancers".freelancer f 
inner join "Freelancers".has_skill hs on f.id = hs.freelancer_id 
inner join "Freelancers".skill s on s.id = hs.skill_id 
inner join "Freelancers".skill_level sl on sl.id = hs.skill_level_id
where f.user_name = 'negar';


-- b)

select p.id, p.project_name
from "Customers & Projects".project p
where p.id not in (
     select op.project_id
     from "Teams".on_project op
);

-- c)
select count(*)
from "Customers & Projects".project p
inner join "Customers & Projects".project_outcome po on po.id = p.project_outcome_id
where po.is_completed_successfully = true;


-- d)

select distinct s.skill_name
from "Teams".team t
inner join "Teams".team_member tm on tm.team_id = t.id
inner join "Freelancers".freelancer f on f.id = tm.freelancer_id
inner join "Freelancers".has_skill hs on hs.freelancer_id = f.id
inner join "Freelancers".skill s on s.id = hs.skill_id
where t.id = 'team_id'; 


-- e)
select count(*)
from "Freelancers".freelancer f
where 1 < ( select count(*)
				from "Teams".team_member t
				where t.freelancer_id = f.id
);


-- f)

select f.id, f.user_name
from "Freelancers".freelancer f 
inner join "Teams".team_member tm on tm.freelancer_id = f.id 
inner join "Teams".team t on t.id = tm.team_id 
inner join "Teams".on_project op on op.team_id = t.id 
inner join "Customers & Projects".project p on p.id = op.project_id 
inner join "Customers & Projects".project_outcome po on po.id = p.project_outcome_id
where po.is_completed_successfully = true 
group by f.id 
order by count(distinct p.id) desc 
limit 1;


--g )
create function project_counts(fid uuid, score boolean) 
returns int
language plpgsql
as 
$$ 
declare
    alls int; 
begin 
    select count(*)
    into alls from "Freelancers".freelancer f
    inner join "Teams".team_member tm on tm.freelancer_id = f.id 
    inner join "Teams".team t on t.id = tm.team_id 
    inner join "Teams".on_project op on op.team_id = t.id 
    inner join "Customers & Projects".project p on p.id = op.project_id                  
    inner join "Customers & Projects".project_outcome po on po.id = p.project_outcome_id
    where f.id = fid and po.is_completed_successfully = score and po.is_completed_unsuccessfull = not score;
    return alls;
end;
$$


create view get_score as
select f.first_name , 2 * project_counts(f.id, true) - 3 * project_counts(f.id, false) as total_s
from "Freelancers".freelancer f;


