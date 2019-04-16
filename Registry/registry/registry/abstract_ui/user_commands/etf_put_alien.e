note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PUT_ALIEN
inherit
	ETF_PUT_ALIEN_INTERFACE
		redefine put_alien end
create
	make
feature -- command
	put_alien(id: INTEGER_64 ; name1: STRING ; dob: TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64] ; country: STRING)
--		require else
--			put_alien_precond(id, name1, dob, country)
    	do
			-- perform some update on the model state
			if not (id > 0) then
				model.set_report (model.err_id_nonpositive)
			elseif not (not model.registry.has_key (id)) then
				model.set_report (model.err_id_taken)
			elseif name1.is_empty then
				model.set_report (model.err_name_start)
			elseif not (name1[1].is_alpha) then
				model.set_report (model.err_name_start)
			elseif not (dob.y > 1899 and dob.y < 3001) then
				model.set_report (model.err_invalid_date)
			elseif not model.check_valid_date(dob) then
				model.set_report (model.err_invalid_date)
			elseif not (country[1].is_alpha) then
				model.set_report (model.err_country_start)
			else
				model.set_report (model.no_err)
				model.put_alien(id, name1, dob, country)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
