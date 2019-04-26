DELIMITER $$
CREATE DEFINER=`sa`@`%` PROCEDURE `GetTpOcpiChargers`(LocationRefIds VARCHAR(500))
BEGIN
Select Evsp.ChargingStationChargerId, Evsp.ChargingStationId,(Select StatusName from `employee.rowstatus` where StatusId = Evsp.ChargingStationChargerStatusId)   AS ChargingStationChargerStatus , ModifiedOn As LastUpdated From `Chargingstation.charger` AS Evsp 
WHERE  
(CASE 
  WHEN (LENGTH(LocationRefIds) > 0 AND LOCATE(',',LocationRefIds) = 0) THEN LocationRefIds LIKE CONCAT('%',Evsp.ChargingStationId,'%')
  WHEN (LENGTH(LocationRefIds) > 0 AND LOCATE(',',LocationRefIds) > 0) THEN LocationRefIds LIKE CONCAT('%',Evsp.ChargingStationId,',','%') OR LocationRefIds LIKE CONCAT('%',',',Evsp.ChargingStationId,'%')
  ELSE (Evsp.ChargingStationId = Evsp.ChargingStationId OR Evsp.ChargingStationId IS NULL) 
END);  
END$$
DELIMITER ;
