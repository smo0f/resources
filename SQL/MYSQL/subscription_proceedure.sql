CREATE DEFINER=`DevTeam`@`%` PROCEDURE `BuildExpectedServTable`(office_id INT, today_date DATE)
BEGIN # Begin the procedure
	
		# Declare our variables for storing our subscription data
		DECLARE Vsub_id INT;
		DECLARE Vsub_name VARCHAR(255);
		DECLARE Vappointment_type VARCHAR(255);
		DECLARE Vappointment_status VARCHAR(255);
		DECLARE Vproduction_value DOUBLE;
		DECLARE Vamount_paid DOUBLE DEFAULT 0;
		DECLARE Vstatus_date DATE DEFAULT NULL;
		DECLARE Vservice_number INT DEFAULT 1;
		DECLARE Vappt_id INT DEFAULT NULL;
		DECLARE Vserviced_by INT DEFAULT NULL;
		DECLARE Vsale_value DOUBLE;
		DECLARE Vinvoiced_value DOUBLE;
		DECLARE Vcustomer_id INT;
		DECLARE Vservice_value DOUBLE;
		
		# Temp variables to use for calculations
		DECLARE Vfrequency VARCHAR(255);
		DECLARE Vfollowup_service INT;
		DECLARE Vagreement_length INT;
		DECLARE Vsale_date DATE;
		DECLARE Vrun_date DATE;
		DECLARE Vend_date DATE;
		DECLARE Vone_time BOOLEAN DEFAULT FALSE;
		DECLARE Vnum_appts INT;
		DECLARE Vappt_loop INT DEFAULT 1;
		DECLARE Vsub_total DOUBLE;
		DECLARE Vtotal DOUBLE;
		DECLARE Vi_total DOUBLE;
		DECLARE Vr_total DOUBLE;
		DECLARE Vwas_added VARCHAR(255);
		DECLARE Vbilling_freq VARCHAR(255);
		DECLARE Vsub_loop_dollar_total DOUBLE DEFAULT 0;
		DECLARE Vleft_i DOUBLE DEFAULT 0;
		DECLARE Vleft_p DOUBLE DEFAULT 0;
		DECLARE Vnum_subs INT DEFAULT 0;
		DECLARE Vsub_offset INT DEFAULT 0;
		
		# Frequency is the number of days between regular services: -1 = one time, 0 = as needed, CUSTOM = custom schedule
		# Follow up is the number of days between the first and follow up service if there is one: -1 = no followup, -3 = custom schedule, 0 =
		
		# Drop the temp subscriptions table if it exists
		DROP TABLE IF EXISTS temp_subscriptions;
		
        # If there is a date that has been passed then get the subscriptions which were added on that date
        IF today_date IS NOT NULL THEN
        
			# Store the subscriptions we are working with in a temporary table, get only the subscriptions for the current office and current month
			CREATE TEMPORARY TABLE temp_subscriptions AS
				(SELECT
					subscriptionID,
					customerID,
					serviceType,
					frequency,
					followupService,
					agreementLength,
					dateAdded,
					contractValue,
					initialServiceTotal,
					recurringCharge,
					billingFrequency
					FROM subscription
					WHERE officeID = office_id AND dateAdded BETWEEN DATE_SUB(DATE_ADD(LAST_DAY(today_date), INTERVAL 1 DAY), INTERVAL 1 MONTH) AND LAST_DAY(today_date)
					ORDER BY subscriptionID DESC);
        
        ELSE
        
			# Store the subscriptions we are working with in a temporary table, get all the subscriptions for the office
			CREATE TEMPORARY TABLE temp_subscriptions AS
				(SELECT
					subscriptionID,
					customerID,
					serviceType,
					frequency,
					followupService,
					agreementLength,
					dateAdded,
					contractValue,
					initialServiceTotal,
					recurringCharge,
					billingFrequency
					FROM subscription
					WHERE officeID = office_id
					ORDER BY subscriptionID DESC);
			
        END IF;
        
		# Declare the subscription offset and number of subscritions in the table
		SET Vnum_subs = (SELECT COUNT(*) FROM subscription WHERE officeID = office_id);
		SET Vsub_offset = 0;
		
		WHILE Vsub_offset <= Vnum_subs DO
	
			# Get the subscription that we are working with
			(SELECT
				subscriptionID,
				customerID,
				serviceType,
				frequency,
				followupService,
				agreementLength,
				dateAdded,
				contractValue,
				initialServiceTotal,
				recurringCharge,
				billingFrequency
				INTO
				Vsub_id,
				Vcustomer_id,
				Vsub_name,
				Vfrequency,
				Vfollowup_service,
				Vagreement_length,
				Vsale_date,
				Vsale_value,
				Vi_total,
				Vr_total,
				Vbilling_freq
			FROM temp_subscriptions
			ORDER BY subscriptionID ASC
			LIMIT 1
			OFFSET Vsub_offset);
			
			# Reset the service number to be the first service for the next subscription record
			SET Vservice_number = 1;
			
			# Set the date of the first service
			SET Vrun_date = Vsale_date;
			
			# If it is a one time service
			IF (Vfrequency <= 0 OR Vagreement_length = 0) THEN
			
				# Set the end date to be the same as the run date so the loop only happens once
				SET Vend_date = Vrun_date;
				
				# Set the boolean for one time service to true
				SET Vone_time = TRUE;
			   
		   # IF it is more than one service
			ELSE
				
				# Set the end date to check against based on the agreement length
				SET Vend_date = DATE_ADD(Vsale_date, INTERVAL Vagreement_length MONTH);
				
				# Set the boolean for one time service to false
				SET Vone_time = FALSE;
				
			END IF;
			
			# Calculate our service schedules
			subLoop: WHILE Vrun_date < Vend_date DO
				
                # Break the loop if we are in the same month / year
                IF (YEAR(Vrun_date) = YEAR(Vend_date) AND MONTH(Vrun_date) = MONTH(Vend_date)) THEN
					LEAVE subLoop;
				END IF;
                
				# Set the appointment type
				IF Vservice_number = 1 THEN
					SET Vappointment_type = 'Initial';
				ELSEIF (Vservice_number = 2 AND Vfollowup_service > 0) THEN
					SET Vappointment_type = 'Followup';
				ELSE
					SET Vappointment_type = 'Regular';
				END IF;
				
				# Change the service value depending on the number of the service
				IF Vservice_number = 1 THEN
					SET Vservice_value = Vi_total;
				ELSE
					SET Vservice_value = Vr_total;
				END IF;
				
				# Create the service record in the customerservicesummary table
				INSERT INTO summary_expectedservice
					(subscriptionID,
					subscriptionName,
					dueDate,
					serviceNumber,
					serviceCategory,
					expectedValue,
					customerID,
                    snapshotDate)
					VALUES
						(Vsub_id,
						Vsub_name,
						Vrun_date,
						Vservice_number,
						Vappointment_type,
						Vservice_value,
						Vcustomer_id,
                        CURDATE())
                        ON DUPLICATE KEY UPDATE
							subscriptionID = Vsub_id,
                            subscriptionName = Vsub_name,
                            dueDate = Vrun_date,
                            serviceNumber = Vservice_number,
                            serviceCategory = Vappointment_type,
                            expectedValue = Vservice_value,
                            customerID = Vcustomer_id,
                            snapshotDate = CURDATE();
				
				# If we are on the first service
				IF (Vservice_number = 1) THEN
				
					SET Vrun_date = DATE_ADD(Vsale_date, INTERVAL Vfollowup_service DAY);
					
				# If we are not on the first service
				ELSE 
				
					SET Vrun_date = DATE_ADD(Vrun_date, INTERVAL Vfrequency DAY);
					
				END IF;
				
				# Increment the service number
				SET Vservice_number = Vservice_number + 1;
			
			END WHILE; # End the insert subscription table while loop
			
			# Increment the subscription offset for the while loop
			SET Vsub_offset = Vsub_offset + 1;
			
		END WHILE; # End of the subscription loop
	
	END