<?
require("const.inc.aspx");
require($home_dir."customsql.inc.aspx");
cheak_ref($_SERVER['HTTP_REFERER']);
require($home_dir."include/constructor_exch.aspx");
require($home_dir."include/class_nal_usl.aspx");
$db = new CustomSQL($DBName);
$db_exchange = new CustomSQL_exchange($DBName_exchange);
$db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
$Constructor = new Constructor();
$Cons_uslugi = new Cons_uslugi();
$errortag = true;
$reqID = wm_ReqID();
if (!empty($_POST['oplata_usluga']) && !empty($_POST['oplata_nal']) && !empty($_POST['oplata_nal_out'])) {
	header("Location: index.aspx");
	exit;
}
	session_start();
	$_SESSION['id'] = md5('1620'.session_id());
$type_usluga = stripslashes(htmlspecialchars(substr($_POST['type_usluga'],0,25)));
$reqID = wm_ReqID();
	$usluga = stripslashes(htmlspecialchars(substr($_POST['usluga'],0,25)));
	$oplata = stripslashes(htmlspecialchars(substr($_POST['oplata'],0,25)));
	$currency = $Cons_uslugi->output($type_usluga,$oplata);
	if(empty($usluga) || empty($oplata)) {header("Location: index.aspx"); exit();}
	$us = $db_pay_desk->select_usluga($usluga,'uslugi');
	$u = $db_exchange->get_kurs($Cons_uslugi->kurs_n($type_usluga,$oplata));
	$userinfo = $db_exchange->exch_balance($Cons_uslugi->bal($type_usluga,$oplata));
	$com_seti = $userinfo[0]["com_seti"];
	$r = $db_exchange->EP_purse_service();
	$balance = $r[0]['balance'] - $r[0]['balance'] * 0.02;
	$info_card = $db_pay_desk->exch_balance('prior');
	$format_balance = edit_balance($balance);
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<Title>Сервис автоматизированного приема платежей</Title>
<Meta name="description" Content="Оплата коммунальных платежей, пополнение счетов интернет-операторов, автоматическое пополнение балансов мобильных телефонов. Оплата услуг производиться электронными валютами: WebMoney (WMZ, WMR, WME, WMU, WMY, WMB, WMG), EasyPay, RBK Money, Yandex Money, Z-payment.">
<Meta name="keywords" Content="коммунальные платежи, пополнение счетов, интернет-операторов, автоматическое пополнение, баланс, мобильный телефон. Оплата услуг, электронные валюты: WebMoney (WMZ, WMR, WME, WMU, WMY, WMB, WMG), EasyPay, RBK Money, Yandex Money, Z-payment, услуг, оплата, Velcom, MTS, life, Dialog, Белтелеком, Космос ТВ, УЖХ, Минск, Могилев, Мозырь, Молодечно, Бобруйск, Молодечно-межрайгаз, Молодечно-водоканал, ГомельЭнерго, МинскЭнерго, Атлант Телеком, ByFly, Айчына Плюс, Шпаркi Дамавiк">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<META NAME="RESOURCE-TYPE" CONTENT="DOCUMENT">
<META content="30 days" name="revisit-after">
<META content="index,follow,all" name="robots">
<META NAME="COPYRIGHT" CONTENT="Copyright (c) by Wm-Rb.net">
<link rel="stylesheet" href="http://service.wm-rb.net/style.css" type="text/css">
<link REL="shortcut icon" HREF="http://wm-rb.net/img/favicon.ico" TYPE="image/x-icon">
<? include($home_dir.'include/js_services.aspx'); ?>
</head>

<body>
<center>
<? include('include/top.aspx');?>


	<tr>
	<td width="700" align="center" class="div_include">
<?include ("include/form_demand_sevices.aspx");?>
<br /><br />

</td>
	</tr>
<?
include('include/bottom.aspx');
?></center>
</body>
</html>
