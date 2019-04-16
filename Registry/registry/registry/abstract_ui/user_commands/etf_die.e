note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_DIE
inherit
	ETF_DIE_INTERFACE
		redefine die end
create
	make
feature -- command
	die(id: INTEGER_64)
--		require else
--			die_precond(id)
    	do
			-- perform some update on the model state
			if not (id > 0) then
				model.set_report (model.err_id_nonpositive)
			elseif not (model.registry.has (id)) then
				model.set_report (model.err_id_unused)
			elseif not (not model.check_if_dead(id)) then
				model.set_report (model.err_dead_already)
			else
				model.set_report (model.no_err)
				model.die(id)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
