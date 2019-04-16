note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_PUT_INTERFACE
inherit
	ETF_COMMAND
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		do
			Precursor(an_etf_cmd_name,etf_cmd_args,an_etf_cmd_container)
			etf_cmd_routine := agent put(? , ? , ?)
			etf_cmd_routine.set_operands (etf_cmd_args)
			if
				attached {INTEGER_64} etf_cmd_args[1] as id and then attached {STRING} etf_cmd_args[2] as name1 and then attached {TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]} etf_cmd_args[3] as dob
			then
				out := "put(" + etf_event_argument_out("put", "id", id) + "," + etf_event_argument_out("put", "name1", name1) + "," + etf_event_argument_out("put", "dob", dob) + ")"
			else
				etf_cmd_error := True
			end
		end

feature -- command precondition 
	put_precond(id: INTEGER_64 ; name1: STRING ; dob: TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]): BOOLEAN
		do  
			Result := 
				         comment ("ID = INTEGER_64")
				and then comment ("NAME = STRING")
				and then 
				is_date(dob)
					-- (1 <= dob.d) and then (dob.d <= 31)
					-- and then (1 <= dob.m) and then (dob.m <= 12)
					-- and then (1900 <= dob.y) and then (dob.y <= 3000)
		ensure then  
			Result = 
				         comment ("ID = INTEGER_64")
				and then comment ("NAME = STRING")
				and then 
				is_date(dob)
					-- (1 <= dob.d) and then (dob.d <= 31)
					-- and then (1 <= dob.m) and then (dob.m <= 12)
					-- and then (1900 <= dob.y) and then (dob.y <= 3000)
		end 
feature -- command 
	put(id: INTEGER_64 ; name1: STRING ; dob: TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64])
		require 
			put_precond(id, name1, dob)
    	deferred
    	end
end
