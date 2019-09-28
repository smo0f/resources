CREATE DEFINER=`DevTeam`@`%` PROCEDURE `LoadArSummaryTable2Current`(currentDate DATE)
BEGIN
    
		# Declare the variables to store the summarized data to put into the summary table
		DECLARE Vtotal_owed DOUBLE(12, 2) DEFAULT 0;
		DECLARE Vtotal_invoiced DOUBLE(12, 2) DEFAULT 0;
		DECLARE Vtotal_paid DOUBLE(12, 2) DEFAULT 0;
		DECLARE Vpercent DOUBLE(12, 4) DEFAULT 0;
		DECLARE Vbranch_name VARCHAR(255);
		DECLARE Vcategory_name VARCHAR(255);
		DECLARE Vmonth_name VARCHAR(255);

		# Declare the variables to use in the loops and queries
		DECLARE Vyear_at INT DEFAULT EXTRACT(YEAR FROM currentDate);
		DECLARE Vmonth_int INT DEFAULT EXTRACT(MONTH FROM currentDate);
        DECLARE Vcurr_date DATE DEFAULT currentDate;
		DECLARE Vinvoice_start_date DATETIME;
        DECLARE Vpayment_start_date DATETIME;
        DECLARE Vpayment_end_date DATETIME;
		DECLARE Vinvoice_end_date DATETIME;
		DECLARE Voffice_id INT DEFAULT 2;
		DECLARE Vcategory_number INT DEFAULT 1;
		
		# Get the data for each office within the month in the year
		WHILE Voffice_id <= 18 DO
			
			# Set the invoice start and end dates to the first day of the month and the last day of the month - 29 days
			SET Vinvoice_start_date = CONCAT(DATE(Vcurr_date), " 23:59:59");
			SET Vinvoice_end_date = CONCAT(DATE(DATE_SUB(Vinvoice_start_date, INTERVAL 29 DAY)), " 00:00:00");
				
			# Reset the category number to 1 = Current
			SET Vcategory_number = 1;
		
			# Get the data for each AR category within each office in each month in the year
			# Category 1 = Current, 2 = 30 Days, 3 = 60 Days, 4 = 90 Days, 5 = 120 Days, 6 = 150 Days
			WHILE Vcategory_number <= 6 DO
			
				# If on the first iteration of the loop then set the solid_date
				IF Vcategory_number = 1 THEN
					SET Vpayment_start_date = Vinvoice_start_date;
					SET Vpayment_end_date = Vinvoice_end_date;
				END IF;
				
				# drop the temp table if it exists so it can be re-created below
				DROP TABLE IF EXISTS temp_tickets_in_category;
				
				# Get the total invoiced and the branch name
				# Create a temporary table that sill store our Ticket Ids that we queried and see if they were paid
				CREATE TEMPORARY TABLE temp_tickets_in_category AS 
					(SELECT 
						ticket.ticketID AS temp_ticketID,
						office.branchName AS temp_branchname,
						ticket.total AS temp_ticket_total,
						ticket.officeID AS temp_officeID
					FROM office 
						INNER JOIN 
							ticket ON office.officeID = ticket.officeID
						WHERE (ticket.invoiceDate BETWEEN Vinvoice_end_date AND Vinvoice_start_date)
							AND ticket.officeID = Voffice_id
                            AND ticket.active = 1);
							
				# Query the temporary table to see how much was invoiced and save into variables
				SELECT 
					SUM(temp_ticket_total),
					temp_branchname
					INTO
					Vtotal_invoiced,
					Vbranch_name
				FROM temp_tickets_in_category;
							
				# Get the total paid by using the ids from the temporary table
				SET Vtotal_paid =
						(SELECT SUM(paymentapplication.appliedAmount)
						FROM paymentapplication
							INNER JOIN 
								temp_tickets_in_category ON temp_ticketID = paymentapplication.ticketID
							WHERE (paymentapplication.dateApplied <= Vpayment_start_date));
				
				# Set the category_name based on what number we are on
				CASE
					WHEN Vcategory_number = 1 THEN SET Vcategory_name = "Current";
					WHEN Vcategory_number = 2 THEN SET Vcategory_name = "30 Days";
					WHEN Vcategory_number = 3 THEN SET Vcategory_name = "60 Days";
					WHEN Vcategory_number = 4 THEN SET Vcategory_name = "90 Days";
					WHEN Vcategory_number = 5 THEN SET Vcategory_name = "120 Days";
					WHEN Vcategory_number = 6 THEN SET Vcategory_name = "150 Days";
				END CASE;
				
				# Set the month_name varable correctly
				CASE
					WHEN Vmonth_int = 1 THEN SET Vmonth_name = "January";
					WHEN Vmonth_int = 2 THEN SET Vmonth_name = "February";
					WHEN Vmonth_int = 3 THEN SET Vmonth_name = "March";
					WHEN Vmonth_int = 4 THEN SET Vmonth_name = "April";
					WHEN Vmonth_int = 5 THEN SET Vmonth_name = "May";
					WHEN Vmonth_int = 6 THEN SET Vmonth_name = "June";
					WHEN Vmonth_int = 7 THEN SET Vmonth_name = "July";
					WHEN Vmonth_int = 8 THEN SET Vmonth_name = "August";
					WHEN Vmonth_int = 9 THEN SET Vmonth_name = "September";
					WHEN Vmonth_int = 10 THEN SET Vmonth_name = "October";
					WHEN Vmonth_int = 11 THEN SET Vmonth_name = "November";
					WHEN Vmonth_int = 12 THEN SET Vmonth_name = "December";
				END CASE;
				
				# Set the variables for total_owed and percent
				SET Vtotal_owed = Vtotal_invoiced - Vtotal_paid;
				SET Vpercent = Vtotal_owed / Vtotal_invoiced;
				
                # Do not insert null branches
                IF Vbranch_name IS NOT NULL THEN
                
					# Insert the data into our arrunningsummary2 table
					INSERT INTO summary_arrunning(
						fulldate,
						monthName,
						monthInt,
						yearAt,
						category,
                        categoryInt,
						branchName,
						owed,
						invoiced,
						percent,
						paid,
                        snapshotDate )
						VALUES (
							Vpayment_start_date,
							Vmonth_name,
							Vmonth_int,
							Vyear_at,
							Vcategory_name,
                            Vcategory_number,
							Vbranch_name,
							Vtotal_owed,
							Vtotal_invoiced,
							Vpercent,
							Vtotal_paid,
                            NOW() )
							ON DUPLICATE KEY UPDATE
								fulldate = Vpayment_start_date,
								monthName = Vmonth_name,
								monthInt = Vmonth_int,
								yearAt = Vyear_at,
								category = Vcategory_name,
                                categoryInt = Vcategory_number,
								branchName = Vbranch_name,
								owed = Vtotal_owed,
								invoiced = Vtotal_invoiced,
								percent = Vpercent,
								paid = Vtotal_paid,
                                snapshotDate = NOW();
                                
				END IF;
					
				# Change the start and end date to the next category by a 29 day interval
                SET Vinvoice_start_date = CONCAT(DATE(DATE_SUB(Vinvoice_end_date, INTERVAL 1 DAY)), " 23:59:59");
				SET Vinvoice_end_date = CONCAT(DATE(DATE_SUB(Vinvoice_start_date, INTERVAL 29 DAY)), " 00:00:00");
				SET Vpayment_end_date = Vinvoice_end_date;
				# Increment all of our loop controls
				SET Vcategory_number = Vcategory_number + 1;
                
			END WHILE; # While loop for categories
			
			# Increment all of our loop controls
			SET Voffice_id = Voffice_id + 1;
		END WHILE; # While loop for Office_ids
        
    END