<?
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
header("Last-Modified: " . gmdate( "D, d M Y H:i:s") . " GMT");
header("Cache-Control: no-cache, must-revalidate");
header("Pragma: no-cache");
header("Content-Type: text/plain; charset=windows-1251");

function test() {
$ch = curl_init('http://service.wm-rb.net/include/history_easypay.aspx');
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1);
$str = curl_exec($ch);
curl_close($ch);
return $str;
}

if (isset($_GET['o'])){
	require("../customsql.inc.aspx");
	require($atm_dir."nncron/constructor_exch_auto.aspx");
	$db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
	$db = new CustomSQL($DBName);
	$db_admin = new CustomSQL_admin($DBName_admin);
	$db_exchange = new CustomSQL_exchange($DBName_exchange);

switch($_GET['o']):
	case  'check_pay_service' :
	$did = substr(trim(stripslashes(htmlspecialchars($_GET['did']))),0,10);
	$sh = substr(trim(stripslashes(htmlspecialchars($_GET['sh']))),0,32);
	$proc = $db_pay_desk->info_dem($did,'n');
	if(!empty($proc)) {
$edit_out_val = trim(sprintf("%8.0f ",$proc[0]['out_val']));
$check_out_val = edit_balance($edit_out_val);

	$local_hesh = md5($did.$proc[0]['purse_out'].$edit_out_val.$s_k);
		if($local_hesh == $sh) {
			switch($proc[0]['output']):
				case  'EasyPay' :
					require($atm_dir."nncron/func_easypay.aspx");
					$p = "EP".$proc[0]['purse_payment'];
					$class_EasyPay = new EasyPay();
					$str = $class_EasyPay->connect_history_easypay($proc[0]['purse_payment'],$$p,'4');
					if(preg_match("/200 OK/i",$str)){
					$check_summe = $class_EasyPay->parser_history_sum($check_out_val,$did,$str);

						if($check_summe == 'AMOUNT_CORRESPONDS') {
							$db_exchange->edit_bal_ep($proc[0]['purse_payment'],$proc[0]['out_val']);
							$db_exchange->upd_time_day($proc[0]['purse_payment']);
							if($proc[0]['partner_id'] == 'shop') {
							shop_new($did,$proc[0]['in_val'],$edit_out_val,$proc[0]['output'],$proc[0]['name_uslugi']);
}
							else { echo check_pay_uslugi($did,$proc['output'],$proc[0]['name_uslugi'],$proc[0]['in_val'],$proc[0]['out_val'],$proc[0]['pole1']);
							}
						}else {echo "Payment_not_executed";}
					}else {echo "ERROR_connect";}
				break;
			endswitch;
		}
		else {echo "Payment_not_executed";}
	}
	else {echo "Pay_paid";}
	break;


	case  'check_cheque_pay' :
	$did = substr(trim(stripslashes(htmlspecialchars($_GET['did']))),0,10);
	$sh = substr(trim(stripslashes(htmlspecialchars($_GET['sh']))),0,32);

	$proc = $db->info_check($did);
	if(!empty($proc)) {
		if($proc[0]['status'] == "n") {
$edit_out_val = trim(sprintf("%8.0f ",$proc[0]['summa_pay']));
$check_out_val = edit_balance($edit_out_val);

	$local_hesh = md5($did.$proc[0]['purse_pay'].$edit_out_val.$s_k);
		if($local_hesh == $sh) {
			require($atm_dir."nncron/func_easypay.aspx");
			//require("Z:/home/wm-rb.net/atm/nncron/func_easypay.aspx");
						//вывод № кошелька на кот. будет выполняться перевод или авторизация для проверки платежа
						//$purse = $db_exchange->sel_purse_out('EasyPay');
						$p = "EP".$proc[0]['purse_payment'];
			$class_EasyPay = new EasyPay();
			$str = $class_EasyPay->connect_history_easypay($proc[0]['purse_payment'],$$p,'4');
			if(preg_match("/200 OK/i",$str)){
				$check_summe = $class_EasyPay->parser_history_sum(trim($check_out_val),$did,$str);
					if($check_summe == 'AMOUNT_CORRESPONDS') {
						//пополнение баланса
						$exch_balance = $db_exchange->exch_balance_service($proc[0]["oplata"]);
						$bal_in = $exch_balance[0]['balance'] + $proc[0]["summa_pay"];
						$db_exchange->demand_update_bal_service($bal_in,$proc[0]["oplata"]);
						$db->st_edit('y',$did);
						echo "Payment_successfully";
					}
					else {echo "Payment_not_executed";}
			}
			else {echo "ERROR_connect";}
		}
		else {echo "Payment_not_executed";}
		}
		else {echo "Pay_paid";}
	}
	else {echo "Pay_paid";}
	break;
endswitch;
}
?>