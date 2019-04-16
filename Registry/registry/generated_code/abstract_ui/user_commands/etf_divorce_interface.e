note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_DIVORCE_INTERFACE
inherit
	ETF_COMMAND
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		do
			Precursor(an_etf_cmd_name,etf_cmd_args,an_etf_cmd_container)
			etf_cmd_routine := agent divorce(? , ?)
			etf_cmd_routine.set_operands (etf_cmd_args)
			if
				attached {INTEGER_64} etf_cmd_args[1] as a_id1 and then attached {INTEGER_64} etf_cmd_args[2] as a_id2
			then
				out := "divorce(" + etf_event_argument_out("divorce", "a_id1", a_id1) + "," + etf_event_argument_out("divorce", "a_id2", a_id2) + ")"
			else
				etf_cmd_error := True
			end
		end

feature -- command precondition 
	divorce_precond(a_id1: INTEGER_64 ; a_id2: INTEGER_64): BOOLEAN
		do  
			Result := 
				comment ("ID = INTEGER_64")
		ensure then  
			Result = 
				comment ("ID = INTEGER_64")
		end 
feature -- command 
	divorce(a_id1: INTEGER_64 ; a_id2: INTEGER_64)
		require 
			divorce_precond(a_id1, a_id2)
    	deferred
    	end
end
