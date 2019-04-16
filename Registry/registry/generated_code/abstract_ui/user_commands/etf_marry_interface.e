note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_MARRY_INTERFACE
inherit
	ETF_COMMAND
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		do
			Precursor(an_etf_cmd_name,etf_cmd_args,an_etf_cmd_container)
			etf_cmd_routine := agent marry(? , ? , ?)
			etf_cmd_routine.set_operands (etf_cmd_args)
			if
				attached {INTEGER_64} etf_cmd_args[1] as id1 and then attached {INTEGER_64} etf_cmd_args[2] as id2 and then attached {TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]} etf_cmd_args[3] as date
			then
				out := "marry(" + etf_event_argument_out("marry", "id1", id1) + "," + etf_event_argument_out("marry", "id2", id2) + "," + etf_event_argument_out("marry", "date", date) + ")"
			else
				etf_cmd_error := True
			end
		end

feature -- command precondition 
	marry_precond(id1: INTEGER_64 ; id2: INTEGER_64 ; date: TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]): BOOLEAN
		do  
			Result := 
				         comment ("ID = INTEGER_64")
				and then 
				is_date(date)
					-- (1 <= date.d) and then (date.d <= 31)
					-- and then (1 <= date.m) and then (date.m <= 12)
					-- and then (1900 <= date.y) and then (date.y <= 3000)
		ensure then  
			Result = 
				         comment ("ID = INTEGER_64")
				and then 
				is_date(date)
					-- (1 <= date.d) and then (date.d <= 31)
					-- and then (1 <= date.m) and then (date.m <= 12)
					-- and then (1900 <= date.y) and then (date.y <= 3000)
		end 
feature -- command 
	marry(id1: INTEGER_64 ; id2: INTEGER_64 ; date: TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64])
		require 
			marry_precond(id1, id2, date)
    	deferred
    	end
end
