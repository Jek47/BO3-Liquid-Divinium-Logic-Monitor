// Inserted code to capture result of RNG rolls

bgb_token_percent_chance(test, player, target_percent){
	random_number = randomfloat(1);
	player.coinflip_result_test[test] = random_number;
	player.coinflip_result_target[test] = target_percent;
	if(target_percent > random_number){
		return true;
	}
	return false;
}

is_bgb_token_in_use(playr){
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use)){
		playr thread update_divinium_test_results(5);
		return false;
	}
	if(!level.onlinegame){
		playr thread update_divinium_test_results(6);
		return false;
	}
	if(!getdvarint("loot_enabled")){
		playr thread update_divinium_test_results(7);
		return false;
	}
	if(isusingmods()){
		playr thread update_divinium_test_results(8);
		return false;
	}
	return true;
}