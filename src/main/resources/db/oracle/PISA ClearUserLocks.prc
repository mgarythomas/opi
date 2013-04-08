create or replace procedure ClearUserLocks (pUserID in char)

  --   Date      Who    P/ER   Action
  -- 27/ 2/07  D Smart         Converted from Sybase.

as
begin
  update Application set OnboardingLock = '' where OnboardingLock = pUserID;
  update Application set CreditLock = '' where CreditLock = pUserID;
  update Application set AMLLock = '' where AMLLock = pUserID;
  update Application set MainLock = '' where MainLock = pUserID;
  commit;
end ClearUserLocks;

--exec ClearUserLocks ('auser');

/
