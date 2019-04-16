note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MARRY
inherit
	ETF_MARRY_INTERFACE
		redefine marry end
create
	make
feature -- command
	marry(id1: INTEGER_64 ; id2: INTEGER_64 ; date: TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64])
--		require else
--			marry_precond(id1, id2, date)
    	do
			-- perform some update on the model state
			if not (id1 /= id2) then
				model.set_report (model.err_id_same)
			elseif not (id1 > 0 and id2 > 0) then
				model.set_report (model.err_id_nonpositive)
			elseif not (date.y > 1899 and date.y < 3001) then
				model.set_report (model.err_invalid_date)
			elseif not model.check_valid_date(date) then
				model.set_report (model.err_invalid_date)
			elseif not (model.registry.has (id1) and model.registry.has (id2)) then
				model.set_report (model.err_id_unused)
			elseif not (model.valid_marriage_date(date, id1) and model.valid_marriage_date(date, id2)) then
				model.set_report (model.err_marry)
			elseif not (not model.check_if_dead(id1) and not model.check_if_dead(id2)) then
				model.set_report (model.err_marry)
			else
				model.set_report (model.no_err)
				model.marry(id1, id2, date)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
