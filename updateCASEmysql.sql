update device_view_filters set parent_id = (select case property_name 

  when 'deviceType' then ifnull((select id from device_types dt where dt.description = property_value), -1)

  when 'deviceModelId' then ifnull((select id from device_models dm where dm.description = property_value), -1)

  when 'status' then (case property_value 

       when 'Unreachable' then 0

       when 'Active' then 1

       when 'Active with agent' then 2 

       when 'Device reachable but authorization failed - wrong ''user name'' or ''password''' then 3 

       when 'Device reachable and authorization succeed' then 4

       else -1

        end)

   when 'proxyId' then ifnull((select id from proxy p where p.proxy_value = property_value), -1)

  when 'deviceInterfaceGroup' then ifnull((select id from groups g where g.name = property_value), -1)

  when 'deviceInterfaceRoleName' then ifnull((select id from roles r where r.name = property_value), -1)

  when 'deviceInterfaceType' then (case property_value 

       when 'Wi-Fi' then 1

       when 'WiMAX' then 2

       when 'Ethernet' then 3

       when 'Mesh' then 4 

       when 'VPN' then 5

       when 'PPP' then 6

       else -1

        end)  

  when 'CS_typeId' then property_value

  when 'CS_assignmentAttributeStateId' then property_value

  end)

where property_value <> '' and property_value is not null;

 

update device_view_filters set property_value = ifnull((select group_concat(id separator ',') from card_type ct where ct.name = property_value), property_value)

where property_name = 'cardTypeId';

 

drop table if exists tmp;

create table tmp(primary key (id), index device_view_id(device_view_id)) ENGINE=MEMORY as select * from device_view_filters dvf where property_name = 'deviceModelId';

update device_view_filters dvf set property_value = NULL 

where property_name = 'deviceModelIdSV'

and not exists (select null from tmp where tmp.device_view_id = dvf.device_view_id and parent_id > 0);

 

drop table if exists tmp;

create table tmp(primary key (id), index device_view_id(device_view_id)) ENGINE=MEMORY as select * from device_view_filters dvf where property_name = 'cardTypeId';

update device_view_filters dvf set property_value = NULL 

where property_name = 'cardTypeIdVersionRevisionID'

and not exists (select null from tmp where tmp.device_view_id = dvf.device_view_id and property_value is not null and property_value <> '');

drop table tmp;
