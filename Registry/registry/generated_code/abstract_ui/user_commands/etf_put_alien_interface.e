note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_PUT_ALIEN_INTERFACE
inherit
	ETF_COMMAND
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		do
			Precursor(an_etf_cmd_name,etf_cmd_args,an_etf_cmd_container)
			etf_cmd_routine := agent put_alien(? , ? , ? , ?)
			etf_cmd_routine.set_operands (etf_cmd_args)
			if
				attached {INTEGER_64} etf_cmd_args[1] as id and then attached {STRING} etf_cmd_args[2] as name1 and then attached {TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]} etf_cmd_args[3] as dob and then attached {STRING} etf_cmd_args[4] as country
			then
				out := "put_alien(" + etf_event_argument_out("put_alien", "id", id) + "," + etf_event_argument_out("put_alien", "name1", name1) + "," + etf_event_argument_out("put_alien", "dob", dob) + "," + etf_event_argument_out("put_alien", "country", country) + ")"
			else
				etf_cmd_error := True
			end
		end

feature -- command precondition 
	put_alien_precond(id: INTEGER_64 ; name1: STRING ; dob: TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64] ; country: STRING): BOOLEAN
		do  
			Result := 
				         comment ("ID = INTEGER_64")
				and then comment ("NAME = STRING")
				and then comment ("COUNTRY = STRING")
				and then 
				is_date(dob)
					-- (1 <= dob.d) and then (dob.d <= 31)
					-- and then (1 <= dob.m) and then (dob.m <= 12)
					-- and then (1900 <= dob.y) and then (dob.y <= 3000)
		ensure then  
			Result = 
				         comment ("ID = INTEGER_64")
				and then comment ("NAME = STRING")
				and then comment ("COUNTRY = STRING")
				and then 
				is_date(dob)
					-- (1 <= dob.d) and then (dob.d <= 31)
					-- and then (1 <= dob.m) and then (dob.m <= 12)
					-- and then (1900 <= dob.y) and then (dob.y <= 3000)
		end 
feature -- command 
	put_alien(id: INTEGER_64 ; name1: STRING ; dob: TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64] ; country: STRING)
		require 
			put_alien_precond(id, name1, dob, country)
    	deferred
    	end
end
