-- Various Admin users
INSERT INTO users VALUES ('ubsadmin1', 'dingo', 'true', 'true');
INSERT INTO authorities VALUES ('ubsadmin1', 'ROLE_DATAENTRY');

INSERT INTO users VALUES ('ubsadmin2', 'wombat', 'true', 'true');
INSERT INTO authorities VALUES ('ubsadmin2', 'ROLE_DATAENTRY');

INSERT INTO users VALUES ('ubsadmin3', 'echidna', 'true', 'true');
INSERT INTO authorities VALUES ('ubsadmin3', 'ROLE_DATAENTRY');

INSERT INTO users VALUES ('ubsadmin4', 'bilby', 'true', 'true');
INSERT INTO authorities VALUES ('ubsadmin4', 'ROLE_DATAENTRY');

INSERT INTO users VALUES ('ubsadmin5', 'platypus', 'true', 'true');
INSERT INTO authorities VALUES ('ubsadmin5', 'ROLE_DATAENTRY');

INSERT INTO users VALUES ('ubsadmin6', 'possum', 'true', 'true');
INSERT INTO authorities VALUES ('ubsadmin6', 'ROLE_DATAENTRY');

INSERT INTO users VALUES ('ubsadmin7', 'magpie', 'true', 'true');
INSERT INTO authorities VALUES ('ubsadmin7', 'ROLE_DATAENTRY');

INSERT INTO users VALUES ('ubsadmin8', 'wallaby', 'true', 'true');
INSERT INTO authorities VALUES ('ubsadmin8', 'ROLE_DATAENTRY');

INSERT INTO users VALUES ('ubsadmin9', 'numbat', 'true', 'true');
INSERT INTO authorities VALUES ('ubsadmin9', 'ROLE_DATAENTRY');

INSERT INTO users VALUES ('ubsadmin0', 'kangaroo', 'true', 'true');
INSERT INTO authorities VALUES ('ubsadmin0', 'ROLE_DATAENTRY');

-- Guru (highest form) of user
INSERT INTO users VALUES ('dalilama', 'bandicoot', 'true', 'true');
INSERT INTO authorities VALUES ('dalilama', 'ROLE_GURU');

commit;

