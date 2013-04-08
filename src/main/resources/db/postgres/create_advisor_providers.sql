insert into advisorprovider(id,advisorid,providerid) 
select  hibernate_sequence.nextval,id, 382 from advisor where id not in (select distinct advisorid from advisorprovider); 

commit;