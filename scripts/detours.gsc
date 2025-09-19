detour zm_score<scripts\zm\_zm_score.gsc>::minus_to_player_score(points){
	//
		self notify("update_test_watchers");
		self.coinflip_result_test[1] = undefined;
		self.coinflip_result_test[3] = undefined;
		self.coinflip_result_test[4] = undefined;
		self.coinflip_result_target[1] = undefined;
		self.coinflip_result_target[3] = undefined;
		self.coinflip_result_target[4] = undefined;
	//
	if(!isdefined(points)){
		self thread update_divinium_test_results(0);
		return;
	}
	if(level.intermission){
		self thread update_divinium_test_results(1);
		return;
	}
	if(self bgb::is_enabled("zm_bgb_shopping_free")){
		self bgb::do_one_shot_use();
		self playsoundtoplayer("zmb_bgb_shoppingfree_coinreturn", self);
		self thread update_divinium_test_results(2);
		return;
	}
	//
		self.last_spend_watcher = points;
	//	
	self.score = self.score - points;
	self.pers["score"] = self.score;
	self incrementplayerstat("scoreSpent", points);
	level notify("spent_points", self, points);
	if(isdefined(level.bgb_in_use) && level.bgb_in_use){
		if(level.onlinegame){
			self bgb_token::function_51cf4361(points);
		}
		else self thread update_divinium_test_results(4);
	}
	else self thread update_divinium_test_results(3);
}

detour bgb_token<scripts\zm\_zm_bgb_token.gsc>::function_51cf4361(points){
	// Validation checks 1 & 2
	if(!is_bgb_token_in_use(self)){
		return;
	}
	// Validation check 3
	if(level.bgb_token_max_per_game >= 0){
		if(self.bgb_tokens_gained_this_game >= level.bgb_token_max_per_game){
			self thread update_divinium_test_results(9);
			return;
		}
	}
	// Test 1
	time_played_total = self zm_stats::get_global_stat("TIME_PLAYED_TOTAL");
	if((time_played_total - 3600) > self.bgb_token_last_given_time){
		if(bgb_token_percent_chance(1, self, 0.33)){
			self thread update_divinium_test_results(10);
			wait 0.1;
			self [[ @bgb_token<scripts\zm\_zm_bgb_token.gsc>::bgb_token_give_to_player ]]();
			return;
		}
		self thread update_divinium_test_results(11);
		return;
	}
	// Test 2
	if(level.round_number < 5){
		self thread update_divinium_test_results(12);
		return;
	}
	// Test 3
	purchase = math::clamp(points, 0, 1000);
	chance = float(purchase) / 1000;
	if(!bgb_token_percent_chance(3, self, chance * 0.33)){
		self thread update_divinium_test_results(13);
		return;
	}
	// Test 4
	rounds_difference = self.var_bc978de9 - level.round_number;
	if(1 > rounds_difference){
		rounds_difference = 1;
	}
	denominator = float(rounds_difference * rounds_difference);
	if(!bgb_token_percent_chance(4, self, 1 / denominator)){
		self thread update_divinium_test_results(14);
		return;
	}
	self thread update_divinium_test_results(15);
	wait 0.1;
	self [[ @bgb_token<scripts\zm\_zm_bgb_token.gsc>::bgb_token_give_to_player ]]();
}