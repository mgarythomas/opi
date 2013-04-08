drop table SignificantUsers;
drop table LocalUsers;

create table LocalUsers
(
  UserID varchar2 (12) not null primary key,
  HashedPassword raw (16) null,
  RoleList varchar2 (80) null,
  PasswordExpiryDate date null,
  RecordCreated date default sysdate
);

create or replace package LocalUserSecurity is
  procedure AddUser (pUserID in varchar2, pRoleList in varchar2);
  procedure ChangePassword (pUserID in varchar2, pOldPassword in varchar2, pNewPassword in varchar2);
  function ChangePassword (pUserID in varchar2, pOldPassword in varchar2, pNewPassword in varchar2) return boolean;
  function ValidateUser (pUserID in varchar2, pPassword in varchar2) return int;
  function GetHashValue (pUserID in varchar2, pPassword in varchar2) return raw;
end LocalUserSecurity;
/

create or replace package body LocalUserSecurity is

  procedure AddUser (pUserID in varchar2, pRoleList in varchar2) is
    errorCode number;
  begin
    insert into LocalUsers (UserID, HashedPassword, RoleList)
    values (upper (pUserID), null, pRoleList);
    commit;
  exception
    when others then
      errorCode := sqlcode;
      dbms_output.put_line ('Error: cant create user ' || pUserID || ' - error code: ' || errorCode);
  end AddUser;
   
  procedure ChangePassword (pUserID in varchar2, pOldPassword in varchar2, pNewPassword in varchar2) is
  begin
    if ChangePassword (pUserID, pOldPassword, pNewPassword) then
      DBMS_OUTPUT.PUT_LINE (pUserID || ' password changed');
    else
      DBMS_OUTPUT.PUT_LINE ('Error: ' || pUserID || ' password change failed');
    end if;
  end ChangePassword;

  function ChangePassword (pUserID in varchar2, pOldPassword in varchar2, pNewPassword in varchar2) return boolean is
    vOK boolean;
  begin
    update LocalUsers 
    set HashedPassword = GetHashValue (pUserID, pNewPassword),
        PasswordExpiryDate = sysdate + 100
    where UserID = upper (pUserID) and
          (HashedPassword = GetHashValue (pUserID, pOldPassword) or
           HashedPassword is null);
    vOK := sql%rowcount = 1;
    commit;
    return vOK;
  end ChangePassword;

  function ValidateUser (pUserID in varchar2, pPassword in varchar2) return int is
    vHashedPassword raw (16);
    vPasswordExpiryDate date;
  begin
    select HashedPassword, PasswordExpiryDate into vHashedPassword, vPasswordExpiryDate
    from LocalUsers
    where UserID = upper (pUserID) and
          (HashedPassword = GetHashValue (pUserID, pPassword) or
           HashedPassword is null);
    if (vHashedPassword is null) or (vPasswordExpiryDate < sysdate) then
      return 1;
    else
      return 2;
    end if;
  exception
    when no_data_found then
      return 0;
  end ValidateUser;
  
  function GetHashValue (pUserID in varchar2, pPassword in varchar2) return raw is
  begin
    return dbms_obfuscation_toolkit.md5 (input => utl_raw.cast_to_raw (upper (pUserID) || '/' || pPassword));
  end GetHashValue;

end LocalUserSecurity;
/

commit;
