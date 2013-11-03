<?
session_start();
if($_SESSION['id'] == md5('1620'.session_id())) {
	require("const.inc.aspx");
require($home_dir."customsql.inc.aspx");
cheak_ref($_SERVER['HTTP_REFERER']);



require($home_dir."include/constructor_exch.aspx");
require($home_dir."include/class_error.aspx");
require($home_dir."mailer/smtp-func.aspx");

$db = new CustomSQL($DBName);
$db_admin = new CustomSQL_admin($DBName_admin);
$Constructor = new Constructor();
$CheckError = new Error();

//if(!empty($_POST['index_check_demand'])) {


//}
//��������� ������ �� ������ ������
if (!empty($_POST['usluga'])) {
if (empty($_POST['usluga'])) {
	header("Location: http://service.wm-rb.net/services_list.aspx");
}
else {
$db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
$db_exchange = new CustomSQL_exchange($DBName_exchange);
//�������������� ������
$in_val = substr(trim(stripslashes(htmlspecialchars($_POST['in_val']))),0,16);
$out_val = substr(trim(stripslashes(htmlspecialchars($_POST['out_val']))),0,16);
$output = substr(trim(stripslashes(htmlspecialchars($_POST['oplata']))),0,16);
$name_uslugi = substr(trim(stripslashes(htmlspecialchars($_POST['name_uslugi']))),0,16);
$p_output = substr(trim(stripslashes(htmlspecialchars($_POST['p_output']))),0,32);
$pole1 = substr(trim(stripslashes(htmlspecialchars($_POST['pole1']))),0,16);
$pole2 = substr(trim(stripslashes(htmlspecialchars($_POST['pole2']))),0,16);
$did = substr(trim(stripslashes(htmlspecialchars($_POST['did']))),0,10);
$email = substr(trim(stripslashes(htmlspecialchars($_POST['email']))),0,64);

$ar_error = $CheckError->Did($did);
$ar_error .= $CheckError->Inval($in_val);
$ar_error .= $CheckError->Inval($out_val);
$ar_error .= $CheckError->Email($email);
$ar_error .= $db_exchange->CheckRate($in_val,$out_val,$output."_usluga","");

	if($ar_error > 0) {header("Location: http://service.wm-rb.net"); exit();}
//���������� �����
$db_pay_desk->add_demand($did,$output,$name_uslugi,$p_output,$in_val,$out_val,$pole1,$pole2,$email,$date_pay,$time_pay,$_COOKIE['partner_id']);
//���������� ������ �������
	$db_admin->add_id_pay($did,$_SERVER['REMOTE_ADDR'],$_SERVER['HTTP_X_FORWARDED_FOR']);

//�������� �� ������� ����������

if($name_uslugi == "VELCOM" || $name_uslugi == "MTS" || $name_uslugi == "LIFE") {
/*
	include($atm_dir."nncron/xml/conf.php");
	include($atm_dir."nncron/xml/wmxiparser.php");
$parser = new WMXIParser();
		$response = $wmxi->X19(
			'7',				# operation_type
			$output, 					# pursetype
			floatval($out_val),				# �����
			$wmid,							# WMID ������������ [userinfo/wmid]
			'',
			'',
			'',
			'',
			'',
			'',
			'',
			'',
			"375".$pole2.$pole1
		);
		$structure = $parser->Parse($response, DOC_ENCODING);
		$transformed = $parser->Reindex($structure, true);
		$kod_error = htmlspecialchars(@$transformed["w3s.response"]["retval"], ENT_QUOTES);
print_r($kod_error);


require($atm_dir."nncron/constructor_exch_auto.aspx");
require_once($atm_dir."nncron/func_wm.aspx");
$class_WebMoney = new WebMoney();
$kod_error = $class_WebMoney->check_X19('7',$output,$out_val,$wmid,"375".$pole2.$pole1);
print_r($kod_error);
echo "<br />";
echo "375".$pole2.$pole1;
if($kod_error != "0") {
	$db_pay_desk->demand_add_coment("ERROR: �� ������� ���������� �������� ���������� ������ �������� � ������� �� ������ ���������� WebMoney ".$kod_error,$did);
	$db_pay_desk->demand_edit_nal('er',$did,'demand_uslugi');
}
*/
}
//��������� ����� ��� ������ ����� � ����� ��������
setcookie($name_uslugi."_1", $pole1, time() + 31104000, "/", "service.wm-rb.net");
setcookie($name_uslugi."_2", $pole2, time() + 31104000, "/", "service.wm-rb.net");
setcookie("uslugi_wmid", $wmid, time() + 31104000, "/", "service.wm-rb.net");
setcookie("email", $email, time() + 31104000, "/", "service.wm-rb.net");


	$from_name = "Robot exchange, WM-RB.net";
	$subject = "����� ������";
	$body = "<div style=\"FONT-SIZE: 12px; FONT-FAMILY: Verdana; COLOR: #676767; LINE-HEIGHT: 18px;\">
<center><b>������������</b></center><br />
-------------------------------------------------<br />
<b>����� ������ ������ :</b> {$did}<br />
-------------------------------------------------<br />
<br />
� ��� ���� 60 �����, ��� �� �������� ������. �� ��������� ����� ������� ������ ����� �������.<br />
���� ������ �� ����� ��������� � ������� 12 �����, �� �����, ���� ��������, ���������� �����, ����� ���������� ������� �� ��� ���� �� ����������� �������� ��������� �������.<br />
��������� ������ ������ ����� �� <a href='http://service.wm-rb.net/user_check_usluga.aspx?d={$did}'>��������</a>
<br />
�� ����� ���������� ��� �� ����� �����������, ����������� �� ������ ����,
����� �� ������ ������ ������ �������� WM-RB.net.<br /><br />

���������� ��� �� ������������� ������ �������.<br />
��� ������ ���������� �������, ������ �� �������.<br />
<br />--<br />
� ���������,<br />
������������� WM-RB.net<br />
<br />
<a href='http://wm-rb.net'>������ �������� WebMoney � ���������� ��������<br />
Mail: <a href='mailto:$support'>$support</a><br />
ICQ: $icq
</div>";
smtpmail($email,$subject,$body,$from_name);
header("Location: http://service.wm-rb.net/user_check_usluga.aspx?d=$did");
}
}
		unset($_SESSION['id']);
		session_destroy();
}
else { header("Location: http://service.wm-rb.net/"); exit(); }
?>