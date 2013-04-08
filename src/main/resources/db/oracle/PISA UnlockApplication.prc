create or replace procedure UnlockApplication (pApplicationID in long,
                                               pUserID in char, 
                                               pUserRole in char)

  --   Date      Who    P/ER   Action
  -- 27/ 2/07  D Smart         Converted from Sybase.
  -- 11/ 4/07  D Smart         Converted to use ID not application number.

as
begin
  if pUserRole = 'Onboarding' then
    update Application set OnboardingLock = '' where ID = pApplicationID and OnboardingLock = pUserID;
  elsif pUserRole = 'Credit' then
    update Application set CreditLock = '' where ID = pApplicationID and CreditLock = pUserID;
  elsif pUserRole = 'AML' then
    update Application set AMLLock = '' where ID = pApplicationID and AMLLock = pUserID;
  else
    update Application set MainLock = '' where ID = pApplicationID and MainLock = pUserID;
  end if;
  commit;
end UnlockApplication;

--exec UnlockApplication ('1049', 'auser', 'Administration');
--exec UnlockApplication ('1049', 'auser', 'Administration');

--exec UnlockApplication ('1049', 'auser', 'Credit');
--exec UnlockApplication ('1049', 'auser', 'Credit');

--exec UnlockApplication ('1049', 'auser', 'Onboarding');
--exec UnlockApplication ('1049', 'auser', 'Onboarding');

/
