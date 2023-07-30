((string) @sql (#contains? @sql "SELECT" "INSERT" "UPDATE" "DELETE" "CREATE" "ALTER" "DROP" "TRUNCATE" "REPLACE" "LOAD" "CALL" "EXECUTE" "DO" "HANDLER" "SET") (#offset! @sql 1 0 -1 0))
(call (argument_list (string (string_content) @injection.content (#set! injection.language "sql"))))
