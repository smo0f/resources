-- @ Key Info
    -- # Key Types 
    -- Key Type 
    -- Definition 

    -- Superkey     
    -- An attribute or combination of attributes that uniquely identifies each row in a table Candidate key A minimal (irreducible) superkey; a superkey that does not contain a subset of attributes that is itself a superkey  

    -- Primary key 
    -- A candidate key selected to uniquely identify all other attribute values in any given row;  cannot contain null entries  

    -- Foreign key 
    -- An attribute or combination of attributes in one table whose values must either match the  primary key in another table or be null  

    -- Secondary key 
    -- An attribute or combination of attributes used strictly for data retrieval purposes 

    -- ? Coronel, Carlos. Database Systems: Design, Implementation, & Management (p. 76). Cengage Learning. Kindle Edition. 

    -- # Integrity Rules  
    -- Entity Integrity 
    -- Description  

    -- Requirement 
    -- All primary key entries are unique, and no part of a primary key may be null.  
    
    -- Purpose 
    -- Each row will have a unique identity, and foreign key values can properly reference primary key values.  
    
    -- Example 
    -- No invoice can have a duplicate number, nor can it be null; in short, all invoices are uniquely identified by their invoice number.  
    
    -- REFERENTIAL INTEGRITY 
    -- DESCRIPTION

    -- Requirement 
    -- A foreign key may have either a null entry, as long as it is not a part of its table’s  primary key, or an entry that matches the primary key value in a table to which it  is related (every non-null foreign key value must reference an existing primary key  value).  
    
    -- Purpose 
    -- It is possible for an attribute not to have a corresponding value, but it will be impossible to have an invalid entry; the enforcement of the referential integrity rule makes it  impossible to delete a row in one table whose primary key has mandatory matching  foreign key values in another table.  
    
    -- Example 
    -- A customer might not yet have an assigned sales representative (number), but it will  be impossible to have an invalid sales representative (number). 

    -- ? Coronel, Carlos. Database Systems: Design, Implementation, & Management (p. 76). Cengage Learning. Kindle Edition. 
