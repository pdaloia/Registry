note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_DIVORCE
inherit
	ETF_DIVORCE_INTERFACE
		redefine divorce end
create
	make
feature -- command
	divorce(a_id1: INTEGER_64 ; a_id2: INTEGER_64)
--		require else
--			divorce_precond(a_id1, a_id2)
    	do
			-- perform some update on the model state
			if not (a_id1 /= a_id2) then
				model.set_report (model.err_id_same)
			elseif not (a_id1 > 0 and a_id2 > 0) then
				model.set_report (model.err_id_nonpositive)
			elseif not (model.registry.has (a_id1) and model.registry.has (a_id2)) then
				model.set_report (model.err_id_unused)
			elseif not (model.check_married(a_id1, a_id2)) then
				model.set_report (model.err_divorce)
			else
				model.set_report (model.no_err)
				model.divorce(a_id1, a_id2)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
