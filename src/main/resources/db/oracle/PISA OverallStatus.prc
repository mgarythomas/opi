create or replace function OverallStatus (pOnboardingValue in number, 
                                          pCreditValue in number,
                                          pAMLValue in number,
                                          pIsDAApproved in varchar2,
                                          pIsBorrowingFromUBS in varchar2,
                                          pIsPurchasingPutFromUBS in varchar2,
                                          pOPIStatus in number,
                                          pApplicationWithdrawn in varchar2,
                                          pApplicationDeleted in varchar2) return varchar2

  --   Date      Who    Action
  -- 22/ 5/07  D Smart  Initial version.
  -- 23/ 5/07  D Smart  Add "ForceNA".

as
  vIsDirectInvestor boolean;
  vBypassOnboardingCheck boolean;
  vBypassCreditCheck boolean;
  vBypassAMLCheck boolean;
  vLowest number;
begin
  vIsDirectInvestor := not ((pIsBorrowingFromUBS = 'true') or (pIsPurchasingPutFromUBS = 'true'));
  vBypassOnboardingCheck := vIsDirectInvestor;
  vBypassCreditCheck := pIsBorrowingFromUBS = 'false';
  vBypassAMLCheck := (pIsDAApproved = 'true') or vIsDirectInvestor;

  if pOPIStatus = 0 then
    return 'Draft';
  elsif pApplicationWithdrawn = 'true' then
    return 'Withdrawn';
  elsif pApplicationDeleted = 'true' then
    return 'Cancelled';
  elsif vIsDirectInvestor then
    return 'Direct';
  else
    vLowest := 99;
    if (pOnboardingValue < vLowest) and not vBypassOnboardingCheck then
      vLowest := pOnboardingValue;
    end if;
    if (pCreditValue < vLowest) and not vBypassCreditCheck then
      vLowest := pCreditValue;
    end if;
    if (pAMLValue < vLowest) and not vBypassAMLCheck then
      vLowest := pAMLValue;
    end if;
    if vLowest = 99 then
      return 'N/A';
    end if;
    return TeamStatusText (vLowest);
  end if;
end OverallStatus;
/
