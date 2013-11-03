<?php

require("const.inc.aspx");
require($home_dir."dbsql.inc.aspx");

function edit_balance($parm) {
$parm = trim(sprintf("%8.0f ",$parm));
$invers_balance = '';
$balance = '';
	$string_len = strlen($parm);
	$c=0;
	for($i=$string_len;$i>=0;$i--) {
		$invers_balance .= $parm[$i];
		if($c == 3) $invers_balance .= " ";
		if($c == 6) $invers_balance .= " ";
		$c++;
	}
	$string_len = strlen($invers_balance);
	for($i=$string_len;$i>=0;$i--) {
		$balance .= $invers_balance[$i];
	}
return $balance;
}

function wm_ReqID(){
    $time=microtime();
    $int=substr($time,11);
    $flo=substr($time,2,3);
	$f=substr($int,0,7);
    return $f.$flo;
}
function cheak_ref($http_ref) {
	$host = explode('/',$http_ref);
if(!preg_match("/[a-zA-Z0-9\.\-]*wm-rb\.net/i",$host[2]))	{
	header("Location: http://service.wm-rb.net");
	exit;
}
}



Class CustomSQL extends DBSQL
{
   // the constructor
   function CustomSQL($DBName = "")
   {
      $this->DBSQL($DBName);
   }
//���� �� ������������� �����
   function info_check($did)
   {
	$sql = "select summa_pay,purse_pay,oplata,status from auto_pay where did ='$did '";
	$result = $this->select($sql);
	return $result;
   }
//���� �� shop
   function sel_shop($host)
   {
	$sql = "select * from terminal where server='$host' or server='www.$host'";
	$result = $this->select($sql);
	return $result;
   }
//����� ������ �� shop�(���������� ��� �������������� �������� �������)
   function autoPay_shop($name_shop)
   {
	$sql = "select percent,purse,refresh_url from terminal where name_shop='$name_shop'";
	$result = $this->select($sql);
	return $result;
   }
//���� �� shop ����� �����������
   function info_sh($login,$pass)
   {
	$sql = "select name_shop,purse,refresh_url from terminal where login='$login' and pass='$pass'";
	$result = $this->select($sql);
	return $result;
   }
//�������� ��
   function cheak_shop($login,$pass)
   {
	$sql = "select * from terminal where login='$login' and pass='$pass'";
	$result = $this->select($sql);
	return $result;
   }
//���������� ������� ����
	function st_edit($st,$did)
	{
	$sql = "update auto_pay set status='$st' where did='$did'";
	$this->update($sql);
	}
}

//����� ��� ������ � ����� EXCHENGE
Class CustomSQL_exchange extends DBSQL_exchange
{
   // the constructor
   function CustomSQL_exchange($DBName_exchange = "")
   {
      $this->DBSQL_exchange($DBName_exchange);
   }
   //����� ������ ����� ��� ������������� ������� �������� ��� �����������
   function EP_purse_input($s_input) {
	global $limitday,$limitmouth;
	$sql = "select acount from acount_easypay where status=1 and st_input=1 and inputday+'$s_input'<{$limitday} and input+'$s_input'<{$limitmouth} order by id ASC LIMIT 1";
	$result = $this->select($sql);return $result;
   }
//��������� ����� �������� ��������
   function edit_bal_ep($acount,$summa) {
	$sql = "update acount_easypay set balance=balance+'$summa',input=input+'$summa',inputday=inputday+'$summa',time_payin=".time()."	where acount='$acount'";
	$results = $this->update($sql); return $results;
   }
//���������� ������� ������� � ����
   function upd_time_day($acount) {
	$sql = "update acount_easypay set firstpayin=".time()." where acount='$acount' and firstpayin=0";
	$results = $this->update($sql);return $results;
   }
//����� ������� ��������� ������(�� ������ ��� ������ ������ �� ������)
   function exch_balance_service($output)
   {
      $sql = "select balance,purse from balance where name_s ='$output'";
      $results = $this->select($sql);
      return $results;
   }
//update ������� ������(�� ������ ��� ������ ������ �� ������)
	function demand_update_bal_service($balance_out,$ex_output)
	{
	$sql = "update balance set balance='$balance_out' where name_s='$ex_output'";
	$results = $this->update($sql);
	return $results;
	}
   //����� ����� ��������� �����
   function sel_cur_exch()
   {
      $sql = "select name,balance,desc_val,st_exch,purse,com_seti from balance where st_pay='1' ORDER BY `id` ASC ";
      $results = $this->select($sql);
      return $results;
   }
   //����� ����� ��������� �����
   function sel_purse($currency)
   {
      $sql = "select purse from balance where name='$currency' and st_pay='1'";
      $results = $this->select($sql);
      return $results;
   }

   //����� ������
   function info_direct($n)
   {
	$sql = "select konvers,direct from kurs where direction='$n'";
	$result = $this->select($sql);
	return $result;
   }
//�������������� �������� ������ � ���������
//����� ������� ��������� ������
   function exch_balance($output)
   {
      $sql = "select balance,purse from balance where name ='$output'";
      $results = $this->select($sql);
      return $results;
   }
//update ������� ������
	function demand_update_bal($balance_out,$ex_output)
	{
	$sql = "update balance set balance='$balance_out' where name='$ex_output'";
	$results = $this->update($sql);
	return $results;
	}
//����� ������ �������� ��������� ������
   function sel_purse_out($output)
   {
      $sql = "select purse from balance where name ='$output'";
      $results = $this->select($sql);
      return $results;
   }
   //����� ������ ����� ��� ������������� ������ �����
   function EP_purse_out_service($s_output)
   {
      $sql = "select acount from acount_easypay where st_output='0' and balance>='$s_output' order by id ASC LIMIT 1";
      $result = $this->select($sql);
      return $result;
   }
}



//����� ��� ������ � ����� ADMIN
Class CustomSQL_admin extends DBSQL_admin
{

   // the constructor
   function CustomSQL_admin($DBName_admin = "")
   {
      $this->DBSQL_admin($DBName_admin);
   }

//���������� ������ �������
   function add_id_pay($did)
   {
      $sql = "insert into id_payment (did) values ('$did')";
      $result = $this->insert($sql);
   }
//����� ����� ������
   function sel_idpay($did)
   {
      $sql = "select id_pay from id_payment where did='$did'";
      $result = $this->select($sql);
      return $result;
   }
}



//����� ��� ������ � ����� PAY-DESK
Class CustomSQL_pay_desk extends DBSQL_pay_desk
{

   // the constructor
   function CustomSQL_pay_desk($DBName_pay_desk = "")
   {
      $this->DBSQL_pay_desk($DBName_pay_desk);
   }
//���������� ����� ����� ��� ������
   function edit_purse_input($did,$purse,$table)
   {
	$sql = "update $table set purse_payment='$purse' where did='$did'";
	$results = $this->update($sql);
	return $results;
   }
//���������� ������ ��� ������
   function add_demand($did,$output,$name_uslugi,$purse_out,$in_val,$out_val,$pole1,$pole2,$email,$date,$time_pay)
   {
      $sql = "insert into demand_uslugi (did,output,name_uslugi,purse_out,out_val,in_val,pole1,pole2,email,data,time,partner_id) values ('$did','$output','$name_uslugi','$purse_out','$in_val','$out_val','$pole1','$pole2','$email','$date','$time_pay','shop')";
      $result = $this->insert($sql);
      return $result;
   }
//��� ������ ���������� �� ���������(������)
   function stat_pay_dem($data_n,$data_k,$name_uslugi)
   {
      $sql = "select did,email,data,time,status from demand_uslugi where name_uslugi='$name_uslugi' and (data >= '$data_n' and data <= '$data_k')";
      $result = $this->select($sql);
      return $result;
   }
//�������� ������� �� ������
   function info_dem($did,$st)
   {
      $sql = "select output,name_uslugi,purse_out,out_val,in_val,pole1,status,partner_id,purse_payment from demand_uslugi where did='$did' and status='$st'";
      $result = $this->select($sql);
      return $result;
   }
//����� ������ �� ������
   function demand_check($did)
   {
      $sql = "select output,name_uslugi,out_val,in_val,pole1,email,data,time,status from demand_uslugi where did='$did'";
      $result = $this->select($sql);
      return $result;
   }
//����� ������� ������
	function demand_edit($st,$did) {
	$sql = "update demand_uslugi set status='{$st}' where did='{$did}'";
	$this->update($sql);
	}
//��� ������������� 100% ������, ������ �����������
	function demand_add_coment($coment,$did)
	{
	$sql = "update demand_uslugi set coment='$coment' where did='$did'";
	$results = $this->update($sql);
	return $results;
	}
//���� �� shop
   function sel_goods($name_company)
   {
	$sql = "select name_card from info_cards where name_company='$name_company' ORDER BY `id` ASC";
	$result = $this->select($sql);
	return $result;
   }
}

?>