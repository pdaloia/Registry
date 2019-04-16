note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit

	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create registry.make (10)
			report := "ok"
		end

feature -- model attributes

	registry: HASH_TABLE [PERSON, INTEGER_64]

feature --precondition checking

	valid_marriage_date(marriage_date: TUPLE [d, m, y: INTEGER_64] ; a_id1: INTEGER_64) : BOOLEAN
		local
			person1: PERSON
			dob1: TUPLE [d, m, y: INTEGER_64]
		do
			person1 := registry.item (a_id1)

			check attached person1 as p1 then
				dob1 := p1.dob
				if (marriage_date.y - dob1.y) > 18 then
					Result := True
				elseif (marriage_date.y - dob1.y) < 18 then
					Result := False
				else
					if dob1.m < marriage_date.m then
						Result := True
					elseif
						dob1.m > marriage_date.m then
						Result := False
					else
						if dob1.d < marriage_date.d  then
							Result := True
						elseif dob1.d > marriage_date.d then
							Result := False
						else
							Result := True
						end
					end
				end
			end
		end

	check_married(a_id1: INTEGER_64; a_id2: INTEGER_64): BOOLEAN
		local
			person1: PERSON
			person2: PERSON
		do
			person1 := registry.item (a_id1)
			person2 := registry.item (a_id2)

			check attached person1 as p1 and attached person2 as p2 then
				if p1.spouse_id = a_id2 and p2.spouse_id = a_id1 then
					Result := True
				else
					Result := False
				end
			end

		end

	check_if_dead(a_id: INTEGER_64) : BOOLEAN
		local
			person1: PERSON
		do
			person1 := registry.item (a_id)
			check attached person1 as p1 then

				if p1.deceased = True then
					Result := True
				else
					Result := false
				end
			end
		end

	check_valid_date(a_date: TUPLE [d, m, y: INTEGER_64]): BOOLEAN
		local
			date1: DATE
		do
			create date1.make_now
			 if date1.is_correct_date (a_date.y.to_integer_32, a_date.m.to_integer_32, a_date.d.to_integer_32) then
			 	Result := True
			 else
			 	Result := False
			 end
		end

feature -- report items

	report : STRING

	no_err: STRING
		attribute Result := "ok" end

	err_id_nonpositive: STRING
		attribute Result := "id must be positive" end

	err_id_taken: STRING
		attribute Result := "id already taken" end

	err_name_start: STRING
		attribute Result := "name must start with A-Z or a-z" end

	err_invalid_date: STRING
		attribute Result := "not a valid date in 1900..3000" end

	err_country_start: STRING
		attribute Result := "country name must start with A-Z or a-z" end

	err_id_same: STRING
		attribute Result := "ids must be different" end

	err_id_unused: STRING
		attribute Result := "id not identified with a person in database" end

	err_marry: STRING
		attribute Result := "proposed marriage invalid" end

	err_divorce: STRING
		attribute Result := "these are not married" end

	err_dead_already: STRING
		attribute Result := "person with that id already dead" end

feature --Set report

	set_report (new_report: STRING)
		do
			report := new_report
		end

feature -- model operations

	reset
			-- Reset model state.
		do
			make
		end

	die (id: INTEGER_64)
		require
			id_positive: id > 0
			id_unused: registry.has (id)
			not_already_dead: not check_if_dead(id)
		local
			person1: PERSON
			person2: PERSON
		do

			person1 := registry.item (id)
			check attached person1 as p1 then
				if person1.is_married then
					check (attached p1.spouse_id as id2) then
						person2 := registry.item (id2)
					end
					check (attached person2 as p2) then
						p1.set_deceased (True)
						p2.set_is_married (False)
					end
				else
					p1.set_deceased(True)
				end
			end
		end

	divorce (a_id1: INTEGER_64; a_id2: INTEGER_64)
		require
			id_not_same: a_id1 /= a_id2
			id_positive: a_id1 > 0 and a_id2 > 0
			id_unused: registry.has (a_id1) and registry.has (a_id2)
			are_married: check_married(a_id1, a_id2)
		local
			person1: PERSON
			person2: PERSON
		do
			person1 := registry.item (a_id1)
			person2 := registry.item (a_id2)
			check attached person1 as p1 and attached person2 as p2 then
				p1.set_is_married (false)
				p2.set_is_married (false)
			end
		end

	marry (id1: INTEGER_64; id2: INTEGER_64; date: TUPLE [d: INTEGER_64; m: INTEGER_64; y: INTEGER_64])
		require
			id_not_same: id1 /= id2
			id_positive: id1 > 0 and id2 > 0
			valid_date: date.y > 1899 and date.y < 3001
			valid_month_and_day: check_valid_date(date)
			id_unused: registry.has (id1) and registry.has (id2)
			valid_age: valid_marriage_date(date, id1) and valid_marriage_date(date, id2)
			not_dead: not check_if_dead(id1) and not check_if_dead(id2)
		local
			person1: PERSON
			person2: PERSON
		do
			person1 := registry.item (id1)
			person2 := registry.item (id2)
			check attached person1 as p1 and attached person2 as p2 then
				p1.set_is_married(True)
				p2.set_is_married (True)
				p1.set_spouse_id (id2)
				p2.set_spouse_id (id1)
				p1.set_spouse_name (p2.name)
				p2.set_spouse_name (p1.name)
				p1.set_marriage_date (date)
				p2.set_marriage_date (date)
			end
		end

	put (id: INTEGER_64; name1: STRING; dob: TUPLE [d: INTEGER_64; m: INTEGER_64; y: INTEGER_64])
		require
			id_positive: id > 0
			id_not_taken: not registry.has_key (id)
			valid_name_start: (not name1.is_empty) and then name1[1].is_alpha
			valid_date: dob.y > 1899 and dob.y < 3001
			valid_month_and_day: check_valid_date(dob)
		local
			person_to_add: PERSON
		do
			create person_to_add.make
			person_to_add.set_id (id)
			person_to_add.set_name (name1)
			person_to_add.set_dob (dob)
			person_to_add.set_country ("Canada")
			person_to_add.set_relationship_status ("Single")
			registry.put (person_to_add, id)
		end

	put_alien (id: INTEGER_64; name1: STRING; dob: TUPLE [d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]; country: STRING)
		require
			id_positive: id > 0
			id_not_taken: not registry.has_key (id)
			valid_name_start: (not name1.is_empty) and then name1[1].is_alpha
			valid_date: dob.y > 1899 and dob.y < 3001
			valid_month_and_day: check_valid_date(dob)
			valid_country_start: country[1].is_alpha
		local
			person_to_add: PERSON
		do
			create person_to_add.make
			person_to_add.set_id (id)
			person_to_add.set_name (name1)
			person_to_add.set_dob (dob)
			person_to_add.set_country (country)
			person_to_add.set_relationship_status ("Single")
			registry.put (person_to_add, id)
		end

feature -- queries

	out: STRING
		local
			list: SORTED_TWO_WAY_LIST [PERSON]
		do

				create Result.make_empty
				Result.append ("  " + report + "%N")

					-- sort `registry'
				create list.make
				across
					registry as cursor
				loop
					list.extend (cursor.item)
				end

					-- printed sorted `registry'
				across
					list as cursor
				loop
					Result.append ("  " + cursor.item.out + "%N")
				end
				Result.remove_tail (1) -- remove last `%N'


		end

end
