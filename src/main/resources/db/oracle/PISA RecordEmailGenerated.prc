create or replace procedure RecordEmailGenerated (pApplicationID in long,
                                                  pEmailType in char,
                                                  pUserID in char)

  --   Date      Who    P/ER   Action
  -- 27/ 2/07  D Smart         Converted from Sybase.
  -- 16/ 5/07  D Smart         Based on Application.ID.

as
begin
  if pEmailType = 'A' then       -- approval
    update Application set ApprovalNotificationDate = sysdate where ID = pApplicationID;
    insert into AuditLog (UserID, Identification, Description) values (pUserID, 'AppID: ' || pApplicationID, 'Approval e-mail generated');
  elsif pEmailType = 'C' then    -- conditional approval
    update Application set ConditionalNotificationDate = sysdate where ID = pApplicationID;
    insert into AuditLog (UserID, Identification, Description) values (pUserID, 'AppID: ' || pApplicationID, 'Conditional approval e-mail generated');
  elsif pEmailType = 'I' then    -- information requested
    update Application set InformationNotificationDate = sysdate where ID = pApplicationID;
    insert into AuditLog (UserID, Identification, Description) values (pUserID, 'AppID: ' || pApplicationID, 'Information request e-mail generated');
  end if;
  commit;
end RecordEmailGenerated;
--exec RecordEmailGenerated (404, 'I', 'iuser');
--exec RecordEmailGenerated (404, 'C', 'cuser');
--exec RecordEmailGenerated (404, 'A', 'auser');
/
