create or replace function TeamStatusTextWithOverride (pStatus in number, pForceNA in boolean) return varchar2

  --   Date      Who    Action
  -- 23/ 5/07  D Smart  Initial version.

as
begin
  if pForceNA then
    return 'N/A';
  end if;
  case pStatus
    when -1 then return 'Rejected';
    when  0 then return 'Pending';
    when  1 then return 'Processing';
    when  2 then return 'Processing - referred internally';
    when  3 then return 'Processing - information required';
    when  4 then return 'Conditional approval';
    when 10 then return 'Approved';
    when 11 then return 'N/A';
  end case;
  return 'Error - status ' || pStatus || ' not known';
end TeamStatusText;
/
