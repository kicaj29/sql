SELECT NAME, line, text
FROM         user_source
WHERE        INSTR (UPPER(text), ' CHAR') > 0
             OR INSTR (UPPER(text), ' CHAR(') > 0
             OR INSTR (UPPER(text), ' CHAR (') > 0;

