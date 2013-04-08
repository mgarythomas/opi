declare 

acl_object_identity_id NUMBER(9);
acl_permission_id NUMBER(9);
acl_object_identity_id_1 NUMBER(9);
acl_object_identity_id_2 NUMBER(9);
acl_object_identity_id_3 NUMBER(9);
acl_object_identity_id_4 NUMBER(9);

begin

delete from users;
delete from authorities;
delete from acl_object_identity;
delete from acl_permission;

commit;

--- Mask integer 0  = no permissions
--- Mask integer 1  = administer
--- Mask integer 2  = read
--- Mask integer 6  = read and write permissions
--- Mask integer 14 = read and write and create permissions

---------------------------------------------------------------------
--- *** INHERITED RIGHTS FOR DIFFERENT INSTANCES AND RECIPIENTS *** 
--- INSTANCE  RECIPIENT         PERMISSION(S) (COMMENT #INSTANCE)
---------------------------------------------------------------------
---    1      ROLE_ADMINISTRATOR   Administer
---    2      ROLE_ADMINISTRATOR   None (overrides parent #1)
---           marissa              Read
---    3      ROLE_ADMINISTRATOR   Administer (from parent #1)
---           scott                Read, Write, Create
---    4      ROLE_ADMINISTRATOR   Administer (from parent #1)
---    5      ROLE_ADMINISTRATOR   Administer (from parent #3)
---           scott                Read, Write, Create (from parent #3)
---    6      ROLE_ADMINISTRATOR   Administer (from parent #3)
---           scott                Administer (overrides parent #3)
---------------------------------------------------------------------

INSERT INTO users VALUES ('marissa', 'koala', 'false', 'true');
INSERT INTO users VALUES ('dianne', 'emu', 'false', 'true');
INSERT INTO users VALUES ('dealer', 'dealer', 'false', 'true');
INSERT INTO users VALUES ('hfaadmin', 'wombat', 'true', 'true');

INSERT INTO authorities VALUES ('marissa', 'ROLE_ADVISOR'); 
INSERT INTO authorities VALUES ('marissa', 'ROLE_DATAENTRY');
INSERT INTO authorities VALUES ('dianne', 'ROLE_ADVISOR');
INSERT INTO authorities VALUES ('dealer', 'ROLE_ADVISOR');
INSERT INTO authorities VALUES ('dealer', 'ROLE_ANONYMOUS');
INSERT INTO authorities VALUES ('hfaadmin', 'ROLE_HFA');

select hibernate_sequence.nextval into acl_object_identity_id from dual;
select hibernate_sequence.currval into acl_object_identity_id_1 from dual;
INSERT INTO acl_object_identity VALUES (acl_object_identity_id, 'org.acegisecurity.acl.DomainObject:1', null, 'org.acegisecurity.acl.basic.SimpleAclEntry');
select hibernate_sequence.nextval into acl_object_identity_id from dual;
select hibernate_sequence.currval into acl_object_identity_id_2 from dual;
INSERT INTO acl_object_identity VALUES (acl_object_identity_id, 'org.acegisecurity.acl.DomainObject:2', acl_object_identity_id_1, 'org.acegisecurity.acl.basic.SimpleAclEntry');
select hibernate_sequence.nextval into acl_object_identity_id from dual;
select hibernate_sequence.currval into acl_object_identity_id_3 from dual;
INSERT INTO acl_object_identity VALUES (acl_object_identity_id, 'org.acegisecurity.acl.DomainObject:3', acl_object_identity_id_1, 'org.acegisecurity.acl.basic.SimpleAclEntry');
select hibernate_sequence.nextval into acl_object_identity_id from dual;
INSERT INTO acl_object_identity VALUES (acl_object_identity_id, 'org.acegisecurity.acl.DomainObject:4', acl_object_identity_id_1, 'org.acegisecurity.acl.basic.SimpleAclEntry');
select hibernate_sequence.nextval into acl_object_identity_id from dual;
INSERT INTO acl_object_identity VALUES (acl_object_identity_id, 'org.acegisecurity.acl.DomainObject:5', acl_object_identity_id_3, 'org.acegisecurity.acl.basic.SimpleAclEntry');
select hibernate_sequence.nextval into acl_object_identity_id from dual;
select hibernate_sequence.currval into acl_object_identity_id_4 from dual;
INSERT INTO acl_object_identity VALUES (acl_object_identity_id, 'org.acegisecurity.acl.DomainObject:6', acl_object_identity_id_3, 'org.acegisecurity.acl.basic.SimpleAclEntry');

select hibernate_sequence.nextval into acl_permission_id from dual;
INSERT INTO acl_permission VALUES (acl_permission_id, acl_object_identity_id_1, 'ROLE_ADMINISTRATOR', 1);
select hibernate_sequence.nextval into acl_permission_id from dual;
INSERT INTO acl_permission VALUES (acl_permission_id, acl_object_identity_id_2, 'ROLE_ADMINISTRATOR', 0);
select hibernate_sequence.nextval into acl_permission_id from dual;
INSERT INTO acl_permission VALUES (acl_permission_id, acl_object_identity_id_2, 'marissa', 2);
select hibernate_sequence.nextval into acl_permission_id from dual;
INSERT INTO acl_permission VALUES (acl_permission_id, acl_object_identity_id_3, 'dealer', 14);
select hibernate_sequence.nextval into acl_permission_id from dual;
INSERT INTO acl_permission VALUES (acl_permission_id, acl_object_identity_id_4, 'dealer', 1);

end;
/

commit;

