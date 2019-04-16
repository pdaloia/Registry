note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_DIE_INTERFACE
inherit
	ETF_COMMAND
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		do
			Precursor(an_etf_cmd_name,etf_cmd_args,an_etf_cmd_container)
			etf_cmd_routine := agent die(?)
			etf_cmd_routine.set_operands (etf_cmd_args)
			if
				attached {INTEGER_64} etf_cmd_args[1] as id
			then
				out := "die(" + etf_event_argument_out("die", "id", id) + ")"
			else
				etf_cmd_error := True
			end
		end

feature -- command precondition 
	die_precond(id: INTEGER_64): BOOLEAN
		do  
			Result := 
				comment ("ID = INTEGER_64")
		ensure then  
			Result = 
				comment ("ID = INTEGER_64")
		end 
feature -- command 
	die(id: INTEGER_64)
		require 
			die_precond(id)
    	deferred
    	end
end
