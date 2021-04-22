/* MIS6330 Lecture 16 - Machine Learning with SQL */

CREATE TABLE iris_copy as select * from class_datasets.iris;
CREATE OR REPLACE VIEW iris_train_data AS SELECT * FROM iris_copy SAMPLE (60) SEED (1);
CREATE OR REPLACE VIEW iris_test_data AS SELECT * FROM iris_copy MINUS SELECT * FROM iris_train_data;

BEGIN DBMS_DATA_MINING.DROP_MODEL('LAB14_MODEL');
EXCEPTION WHEN OTHERS THEN NULL; END;
/
DECLARE
    v_setlst DBMS_DATA_MINING.SETTING_LIST;
    
BEGIN
    v_setlst('PREP_AUTO') := 'ON';
    v_setlst('ALGO_NAME') := 'ALGO_DECISION_TREE';
    
    DBMS_DATA_MINING.CREATE_MODEL2(
        'LAB4_MODEL',
        'CLASSIFICATION',
        'SELECT * FROM iris_train_data',
        v_setlst,
        'ID',
        'SPECIES');
END;
/

--What model views were created?
SELECT VIEW_NAME, VIEW_TYPE 
  FROM USER_MINING_MODEL_VIEWS
  WHERE MODEL_NAME='LAB4_MODEL'
  ORDER BY VIEW_NAME;

--Look at the decision tree statistics view
SELECT * from DM$VILAB4_MODEL;

--Evaluate the model
BEGIN EXECUTE IMMEDIATE 'DROP TABLE LAB4_APPLY_RESULTS PURGE';
EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE LAB4_LIFT_TABLE PURGE';
EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN
  DBMS_DATA_MINING.APPLY('LAB4_MODEL','iris_test_data','ID','LAB4_APPLY_RESULTS');
  DBMS_DATA_MINING.COMPUTE_LIFT('LAB4_APPLY_RESULTS','iris_test_data','ID','species',
                                'LAB4_LIFT_TABLE','1','PREDICTION','PROBABILITY',100);
END;
/

--Show predictions with actual
SELECT A.*, B.* 
  FROM lab4_apply_results A
  INNER JOIN iris_test_data B ON a.id = b.id;
  
--How many did we get wrong?
SELECT sum(case when prediction <> species then 1 else 0 end) as wrong_count
    , count(*) as total_count
    , sum(case when prediction <> species then 1 else 0 end) /
    count(*) as wrong_percentage
FROM lab4_apply_results A
INNER JOIN iris_test_data B ON a.id = b.id;