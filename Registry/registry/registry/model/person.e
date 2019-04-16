note
	description: "Summary description for {PERSON_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PERSON

inherit
	COMPARABLE
		redefine
			is_equal, out
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			id := 0
			spouse_id:=0
			create name.make_empty
			create dob.default_create
			create country.make_empty
			deceased:= false
			is_married := false
			create relationship_status.make_empty
			create spouse_id.default_create
			create spouse_name.make_empty
			create marriage_date.default_create

		end

feature{PERSON, ETF_MODEL}
	id: INTEGER_64
	name: STRING
	dob: TUPLE [d, m, y: INTEGER_64]
	country: STRING
	deceased: BOOLEAN
	is_married: BOOLEAN
	relationship_status: STRING
	spouse_id: INTEGER_64
	spouse_name: STRING
	marriage_date: TUPLE [d, m, y: INTEGER_64]

feature

	set_id (a_id: INTEGER_64)
		do
			id := a_id
		end

	set_name(a_name: STRING)
		do
			name:=a_name
		end

	set_dob(a_dob: TUPLE [d, m, y: INTEGER_64])
		do
			dob:=a_dob
		end
	set_country(a_country: STRING)
		do
			country:=a_country
		end
	set_deceased(dead: BOOLEAN)
		do
			deceased:=dead
		end
	set_is_married(a_married: BOOLEAN)
		do
			is_married:=a_married
		end
	set_relationship_status(a_status: STRING)
		do
			relationship_status:=a_status
		end
	set_spouse_id(a_spouse_id: INTEGER_64)
	do
		spouse_id:=a_spouse_id
	end
	set_spouse_name(a_spouse_name: STRING)
	do
		spouse_name:=a_spouse_name
	end
	set_marriage_date(a_marriage_date: TUPLE [d, m, y: INTEGER_64])
	do
		marriage_date:=a_marriage_date
	end

feature


	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			if Current = other then
				Result := False
			elseif name < other.name then
				Result := True
			elseif name ~ other.name then
				Result := id < other.id
			else
				Result := False
			end
		end


	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			if Current = other then
				Result := True
			else
				Result := (id = other.id)
			end
		end

feature

	out: STRING
		do
			create Result.make_from_string(name + "; ID: " + id.out + "; Born: " + tuple_to_date (dob))
			Result.append ("; Citizen: " + country + "; ")
			if is_married and not deceased then
				Result.append ("Spouse: " + spouse_name + "," + spouse_id.out + ",[" + tuple_to_date (marriage_date) + "]")
			elseif deceased then
				Result.append ("Deceased")
			else
				Result.append ("Single")
			end
		end

	tuple_to_date (date: TUPLE [d, m, y: INTEGER_64]): STRING
		do
			create Result.make_from_string (date.y.out + "-")
			if date.m  <= 9 then
				Result.append ("0")
			end
			Result.append (date.m.out + "-")
			if date.d  <= 9 then
				Result.append ("0")
			end
			Result.append (date.d.out)
		end

end
