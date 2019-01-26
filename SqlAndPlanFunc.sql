-- This function allow you to take the relevant information about execution plans from sql server which were executed on your sql server
-- Params : Requested => query plan handle (binary identifier)


CREATE function SqlAndPlan(@handle varbinary(max))
returns table as
return select sql.text, 
		cp.usecounts, 
		cp.cacheobjtype,
		cp.objtype,
		cp.size_in_bytes,
		qp.query_plan
from 
	sys.dm_exec_sql_text(@handle) as sql cross join
	sys.dm_exec_query_plan(@handle) as qp
	join sys.dm_exec_cached_plans as cp
	on cp.plan_handle = @handle
go
