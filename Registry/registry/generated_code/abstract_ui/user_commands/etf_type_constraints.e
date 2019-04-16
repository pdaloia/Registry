class
 	 ETF_TYPE_CONSTRAINTS

feature -- type queries 

	is_day(etf_v: INTEGER_64): BOOLEAN 
		require
			comment("etf_v: DAY = 1 .. 31")
		do
			 Result := 
				(1 <= etf_v) and then (etf_v <= 31)
		ensure
			 Result = 
				(1 <= etf_v) and then (etf_v <= 31)
		end

	is_month(etf_v: INTEGER_64): BOOLEAN 
		require
			comment("etf_v: MONTH = 1 .. 12")
		do
			 Result := 
				(1 <= etf_v) and then (etf_v <= 12)
		ensure
			 Result = 
				(1 <= etf_v) and then (etf_v <= 12)
		end

	is_year(etf_v: INTEGER_64): BOOLEAN 
		require
			comment("etf_v: YEAR = 1900 .. 3000")
		do
			 Result := 
				(1900 <= etf_v) and then (etf_v <= 3000)
		ensure
			 Result = 
				(1900 <= etf_v) and then (etf_v <= 3000)
		end

	is_date(etf_v: TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]): BOOLEAN 
		require
			comment("etf_v: DATE = TUPLE[d: DAY = 1 .. 31; m: MONTH = 1 .. 12; y: YEAR = 1900 .. 3000]")
		do
			 Result := 
				         is_day(etf_v.d)
				and then is_month(etf_v.m)
				and then is_year(etf_v.y)
		ensure
			 Result = 
				         is_day(etf_v.d)
				and then is_month(etf_v.m)
				and then is_year(etf_v.y)
		end
feature -- list of enumeratd constants
	enum_items : HASH_TABLE[INTEGER, STRING]
		do
			create Result.make (10)
		end

	enum_items_inverse : HASH_TABLE[STRING, INTEGER_64]
		do
			create Result.make (10)
		end
feature -- query on declarations of event parameters
	evt_param_types_table : HASH_TABLE[HASH_TABLE[ETF_PARAM_TYPE, STRING], STRING]
		local
			put_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			put_alien_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			marry_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			divorce_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			die_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
		do
			create Result.make (10)
			Result.compare_objects
			create put_param_types.make (10)
			put_param_types.compare_objects
			put_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("ID", create {ETF_INT_PARAM}), "id")
			put_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("NAME", create {ETF_STR_PARAM}), "name1")
			put_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("DATE", create {ETF_TUPLE_PARAM}.make(<<create {ETF_PARAM_DECL}.make("d", create {ETF_NAMED_PARAM_TYPE}.make("DAY", create {ETF_INTERVAL_PARAM}.make(1, 31))), create {ETF_PARAM_DECL}.make("m", create {ETF_NAMED_PARAM_TYPE}.make("MONTH", create {ETF_INTERVAL_PARAM}.make(1, 12))), create {ETF_PARAM_DECL}.make("y", create {ETF_NAMED_PARAM_TYPE}.make("YEAR", create {ETF_INTERVAL_PARAM}.make(1900, 3000)))>>)), "dob")
			Result.extend (put_param_types, "put")
			create put_alien_param_types.make (10)
			put_alien_param_types.compare_objects
			put_alien_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("ID", create {ETF_INT_PARAM}), "id")
			put_alien_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("NAME", create {ETF_STR_PARAM}), "name1")
			put_alien_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("DATE", create {ETF_TUPLE_PARAM}.make(<<create {ETF_PARAM_DECL}.make("d", create {ETF_NAMED_PARAM_TYPE}.make("DAY", create {ETF_INTERVAL_PARAM}.make(1, 31))), create {ETF_PARAM_DECL}.make("m", create {ETF_NAMED_PARAM_TYPE}.make("MONTH", create {ETF_INTERVAL_PARAM}.make(1, 12))), create {ETF_PARAM_DECL}.make("y", create {ETF_NAMED_PARAM_TYPE}.make("YEAR", create {ETF_INTERVAL_PARAM}.make(1900, 3000)))>>)), "dob")
			put_alien_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("COUNTRY", create {ETF_STR_PARAM}), "country")
			Result.extend (put_alien_param_types, "put_alien")
			create marry_param_types.make (10)
			marry_param_types.compare_objects
			marry_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("ID", create {ETF_INT_PARAM}), "id1")
			marry_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("ID", create {ETF_INT_PARAM}), "id2")
			marry_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("DATE", create {ETF_TUPLE_PARAM}.make(<<create {ETF_PARAM_DECL}.make("d", create {ETF_NAMED_PARAM_TYPE}.make("DAY", create {ETF_INTERVAL_PARAM}.make(1, 31))), create {ETF_PARAM_DECL}.make("m", create {ETF_NAMED_PARAM_TYPE}.make("MONTH", create {ETF_INTERVAL_PARAM}.make(1, 12))), create {ETF_PARAM_DECL}.make("y", create {ETF_NAMED_PARAM_TYPE}.make("YEAR", create {ETF_INTERVAL_PARAM}.make(1900, 3000)))>>)), "date")
			Result.extend (marry_param_types, "marry")
			create divorce_param_types.make (10)
			divorce_param_types.compare_objects
			divorce_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("ID", create {ETF_INT_PARAM}), "a_id1")
			divorce_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("ID", create {ETF_INT_PARAM}), "a_id2")
			Result.extend (divorce_param_types, "divorce")
			create die_param_types.make (10)
			die_param_types.compare_objects
			die_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("ID", create {ETF_INT_PARAM}), "id")
			Result.extend (die_param_types, "die")
		end
feature -- query on declarations of event parameters
	evt_param_types_list : HASH_TABLE[LINKED_LIST[ETF_PARAM_TYPE], STRING]
		local
			put_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			put_alien_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			marry_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			divorce_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			die_param_types: LINKED_LIST[ETF_PARAM_TYPE]
		do
			create Result.make (10)
			Result.compare_objects
			create put_param_types.make
			put_param_types.compare_objects
			put_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("ID", create {ETF_INT_PARAM}))
			put_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("NAME", create {ETF_STR_PARAM}))
			put_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("DATE", create {ETF_TUPLE_PARAM}.make(<<create {ETF_PARAM_DECL}.make("d", create {ETF_NAMED_PARAM_TYPE}.make("DAY", create {ETF_INTERVAL_PARAM}.make(1, 31))), create {ETF_PARAM_DECL}.make("m", create {ETF_NAMED_PARAM_TYPE}.make("MONTH", create {ETF_INTERVAL_PARAM}.make(1, 12))), create {ETF_PARAM_DECL}.make("y", create {ETF_NAMED_PARAM_TYPE}.make("YEAR", create {ETF_INTERVAL_PARAM}.make(1900, 3000)))>>)))
			Result.extend (put_param_types, "put")
			create put_alien_param_types.make
			put_alien_param_types.compare_objects
			put_alien_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("ID", create {ETF_INT_PARAM}))
			put_alien_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("NAME", create {ETF_STR_PARAM}))
			put_alien_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("DATE", create {ETF_TUPLE_PARAM}.make(<<create {ETF_PARAM_DECL}.make("d", create {ETF_NAMED_PARAM_TYPE}.make("DAY", create {ETF_INTERVAL_PARAM}.make(1, 31))), create {ETF_PARAM_DECL}.make("m", create {ETF_NAMED_PARAM_TYPE}.make("MONTH", create {ETF_INTERVAL_PARAM}.make(1, 12))), create {ETF_PARAM_DECL}.make("y", create {ETF_NAMED_PARAM_TYPE}.make("YEAR", create {ETF_INTERVAL_PARAM}.make(1900, 3000)))>>)))
			put_alien_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("COUNTRY", create {ETF_STR_PARAM}))
			Result.extend (put_alien_param_types, "put_alien")
			create marry_param_types.make
			marry_param_types.compare_objects
			marry_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("ID", create {ETF_INT_PARAM}))
			marry_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("ID", create {ETF_INT_PARAM}))
			marry_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("DATE", create {ETF_TUPLE_PARAM}.make(<<create {ETF_PARAM_DECL}.make("d", create {ETF_NAMED_PARAM_TYPE}.make("DAY", create {ETF_INTERVAL_PARAM}.make(1, 31))), create {ETF_PARAM_DECL}.make("m", create {ETF_NAMED_PARAM_TYPE}.make("MONTH", create {ETF_INTERVAL_PARAM}.make(1, 12))), create {ETF_PARAM_DECL}.make("y", create {ETF_NAMED_PARAM_TYPE}.make("YEAR", create {ETF_INTERVAL_PARAM}.make(1900, 3000)))>>)))
			Result.extend (marry_param_types, "marry")
			create divorce_param_types.make
			divorce_param_types.compare_objects
			divorce_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("ID", create {ETF_INT_PARAM}))
			divorce_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("ID", create {ETF_INT_PARAM}))
			Result.extend (divorce_param_types, "divorce")
			create die_param_types.make
			die_param_types.compare_objects
			die_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("ID", create {ETF_INT_PARAM}))
			Result.extend (die_param_types, "die")
		end
feature -- comments for contracts
	comment(etf_s: STRING): BOOLEAN
		do
			Result := TRUE
		end
end