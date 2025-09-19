texts(){
	self.logic_monitor_title = self thread add_text( "Liquid Divinium Logic Monitor v1  |  Jek47", 2, 0, 0, 1280, (0.118, 0.392, 1) );
	self thread last_spend_watcher();
	self thread one_hour_watcher();
	self thread target_round_watcher();
	self thread setup_divinium_test_info();
}

add_text( text, alignment, x, y, width, rgb){    
    textElement = self OpenLUIMenu( "HudElementText" );
    //0 - LEFT | 1 - RIGHT | 2 - CENTER
    self SetLuiMenuData( textElement, "alignment", alignment );
    self SetLuiMenuData( textElement, "x", x );
    self SetLuiMenuData( textElement, "y", y );
    self SetLuiMenuData( textElement, "width", width );
    self SetLuiMenuData( textElement, "text", text );
    self SetLUIMenuData( textElement, "red", rgb[0] );
    self SetLUIMenuData( textElement, "green", rgb[1] );
    self SetLUIMenuData( textElement, "blue", rgb[2] );
    return textElement;
}

setup_divinium_test_info(){
	self.title_txt = self thread add_text( "", 1, 25, 25, 1280, (1,1,1) );
	self.result_txt = self thread add_text( "", 1, 170, 25, 1280, (1,1,1) );
	self.line_1 = self thread add_text( "", 1, 25, 50, 1280, (1,1,1) );
	self.line_2 = self thread add_text( "", 1, 25, 75, 1280, (1,1,1) );
	self.line_3 = self thread add_text( "", 1, 25, 100, 1280, (1,1,1) );
	self.line_4 = self thread add_text( "", 1, 25, 125, 1280, (1,1,1) );
	self.line_5 = self thread add_text( "", 1, 25, 150, 1280, (1,1,1) );
}

last_spend_watcher(){
	self endon("disconnect");
	self.last_spend_txt = self thread add_text( " ", 0, 25, 225, 1280, (1,1,1) );
	self waittill("update_test_watchers");
	self.last_spend_watcher = 0;
	points_spent_display = -1;
	while(true){
		while(points_spent_display == self.last_spend_watcher){
			wait 0.01;
		}
		points_spent_display = self.last_spend_watcher;
		self SetLuiMenuData( self.last_spend_txt, "text", "Last Purchase: " + points_spent_display );
		wait 0.01;
	}
}

one_hour_watcher(){
	self endon("disconnect");
	self.one_hour_txt = self thread add_text( " ", 0, 25, 250, 1280, (1,1,1) );
	while(true){
		self waittill("update_test_watchers");
		time_played_total = self zm_stats::get_global_stat("TIME_PLAYED_TOTAL");
		last_given_time = self.bgb_token_last_given_time;
		time_ago = time_played_total - last_given_time;
		self SetLuiMenuData( self.one_hour_txt, "text", "Last Divinium: " + time_ago + " secs ago" );
	}
}

target_round_watcher(){
	self endon("disconnect");
	self.target_round_txt = self thread add_text( " ", 0, 25, 325, 1280, (1,1,1) );
	self waittill("update_test_watchers");
	target_round_display = 0;
	while(true){
		while(target_round_display == self.var_bc978de9){
			wait 0.01;
		}
		target_round_display = self.var_bc978de9;
		self SetLuiMenuData( self.target_round_txt, "text", "Current Target Round: " + target_round_display );
		wait 0.01;
	}
}

update_divinium_test_results(result){
	if(!isdefined (firstRun)){
		firstRun=true;
		self SetLuiMenuData( self.title_txt, "text", "Last Divinium result:" );
	}
	self clear_all_lines();
	switch(result){
		case 0:{
			self thread result_fail_txt();
			self SetLuiMenuData( self.line_1, "text", "Validation fail" );
			self SetLuiMenuData( self.line_2, "text", "{points} is not defined" );
		}
		case 1:{
			self thread result_fail_txt();
			self SetLuiMenuData( self.line_1, "text", "Validation fail" );
			self SetLuiMenuData( self.line_2, "text", "{level.intermission} == true" );
		}
		case 2:{
			self thread result_fail_txt();
			self SetLuiMenuData( self.line_1, "text", "Validation fail" );
			self SetLuiMenuData( self.line_2, "text", "{zm_bgb_shopping_free} is enabled" );
		}
		case 3:{
			self thread result_fail_txt();
			self SetLuiMenuData( self.line_1, "text", "Validation fail" );
			self SetLuiMenuData( self.line_2, "text", "{level.bgb_in_use} == false" );
		}
		case 4:{
			self thread result_fail_txt();
			self SetLuiMenuData( self.line_1, "text", "Validation fail" );
			self SetLuiMenuData( self.line_2, "text", "{level.onlinegame} == false" );
		}
		case 5:{
			self thread result_fail_txt();
			self SetLuiMenuData( self.line_1, "text", "Validation fail" );
			self SetLuiMenuData( self.line_2, "text", "{level.bgb_in_use} == false" );
		}
		case 6:{
			self thread result_fail_txt();
			self SetLuiMenuData( self.line_1, "text", "Validation fail" );
			self SetLuiMenuData( self.line_2, "text", "{level.onlinegame} == false" );
		}
		case 7:{
			self thread result_fail_txt();
			self SetLuiMenuData( self.line_1, "text", "Validation fail" );
			self SetLuiMenuData( self.line_2, "text", "dvarint {loot_enabled} == false" );
		}
		case 8:{
			self thread result_fail_txt();
			self SetLuiMenuData( self.line_1, "text", "Validation fail" );
			self SetLuiMenuData( self.line_2, "text", "{isusingmods()} == true" );
		}
		case 9:{
			self thread result_fail_txt();
			self SetLuiMenuData( self.line_1, "text", "Validation fail" );
			self SetLuiMenuData( self.line_2, "text", "{player.bgb_tokens_gained_this_game} >= {level.bgb_token_max_per_game}" );
		}
		case 10:{
			self thread result_pass_txt();
			self SetLuiMenuData( self.line_1, "text", "Test 1: Pass  |  > 1 hour since Last Divinium" );
			self SetLuiMenuData( self.line_2, "text", "You rolled: " + self.coinflip_result_test[1] + " < 0.33");
		}
		case 11:{
			self thread result_fail_txt();
			self SetLuiMenuData( self.line_1, "text", "Test 1: Fail  |  > 1 hour since Last Divinium" );
			self SetLuiMenuData( self.line_2, "text", "You rolled: " + self.coinflip_result_test[1] + " >= 0.33");
		}
		case 12:{
			self thread result_fail_txt();
			self SetLuiMenuData( self.line_1, "text", "Test 1: Pass  |  < 1 hour since Last Divinium" );
			self SetLuiMenuData( self.line_2, "text", "Test 2: Fail" );
			self SetLuiMenuData( self.line_3, "text", "{level.round_number < 5}" );
		}
		case 13:{
			self thread result_fail_txt();
			self SetLuiMenuData( self.line_1, "text", "Test 1: Pass  |  < 1 hour since Last Divinium" );
			self SetLuiMenuData( self.line_2, "text", "Test 2: Pass  |  {level.round_number > 5}" );
			self SetLuiMenuData( self.line_3, "text", "Test 3: Fail" );
			self SetLuiMenuData( self.line_4, "text", "You rolled: " + self.coinflip_result_test[3] + " >= " + self.coinflip_result_target[3]);
		}
		case 14:{
			self thread result_fail_txt();
			self SetLuiMenuData( self.line_1, "text", "Test 1: Pass  |  < 1 hour since Last Divinium" );
			self SetLuiMenuData( self.line_2, "text", "Test 2: Pass  |  {level.round_number > 5}" );
			self SetLuiMenuData( self.line_3, "text", "Test 3: Pass  |  {Rolled: " + self.coinflip_result_test[3] + " < " + self.coinflip_result_target[3] + "}");
			self SetLuiMenuData( self.line_4, "text", "Test 4: Fail");
			self SetLuiMenuData( self.line_5, "text", "You rolled: " + self.coinflip_result_test[4] + " >= " + self.coinflip_result_target[4]);
		}
		case 15:{
			self thread result_pass_txt();
			self SetLuiMenuData( self.line_1, "text", "Test 1: Pass  |  < 1 hour since Last Divinium" );
			self SetLuiMenuData( self.line_2, "text", "Test 2: Pass  |  {level.round_number > 5}" );
			self SetLuiMenuData( self.line_3, "text", "Test 3: Pass  |  {Rolled: " + self.coinflip_result_test[3] + " < " + self.coinflip_result_target[3] + "}");
			self SetLuiMenuData( self.line_4, "text", "Test 4: Pass  |  {Rolled: " + self.coinflip_result_test[4] + " < " + self.coinflip_result_target[4] + "}");
		}
	}
}

result_fail_txt(){
	self SetLuiMenuData( self.result_txt, "text", "FAIL" );
	self SetLuiMenuData( self.result_txt, "red", 1 );
	self SetLuiMenuData( self.result_txt, "green", 0 );
	self SetLuiMenuData( self.result_txt, "blue", 0 );
}

result_pass_txt(){
	self SetLuiMenuData( self.result_txt, "text", "PASS" );
	self SetLuiMenuData( self.result_txt, "red", 0 );
	self SetLuiMenuData( self.result_txt, "green", 1 );
	self SetLuiMenuData( self.result_txt, "blue", 0 );
}

clear_all_lines(){
	self SetLuiMenuData( self.result_txt, "text", "" );
	self SetLuiMenuData( self.line_1, "text", "" );
	self SetLuiMenuData( self.line_2, "text", "" );
	self SetLuiMenuData( self.line_3, "text", "" );
	self SetLuiMenuData( self.line_4, "text", "" );
	self SetLuiMenuData( self.line_5, "text", "" );
}