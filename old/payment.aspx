<?php
require("const.inc.aspx");
require($home_dir."customsql.inc.aspx");
$db = new CustomSQL($DBName);
$db_admin = new CustomSQL_admin($DBName_admin);
$db_exchange = new CustomSQL_exchange($DBName_exchange);
if(!empty($_POST['add_autopay'])) {
	$reqID = wm_ReqID();
	$info_shop = $db->sel_shop($_POST['partner']);
	$db_admin->add_id_pay($reqID,$_SERVER['REMOTE_ADDR'],$_SERVER['HTTP_X_FORWARDED_FOR']);
	$db->add_auto_pay($reqID,$_POST['summa'],$info_shop[0]['percent'],$info_shop[0]['part_summa'],$info_shop[0]['purse'],$_POST['partner']);
}
if(!empty($_POST['pay_autopay'])) {
$db->edit_auto_pay($_POST['did'],$_POST['oplata'],$_POST['summa_pay'],$_POST['purse']);
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Платежный терминал WM-RB.net</title>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<link rel="stylesheet" href="style.css" type="text/css">
<meta content="none" name="ROBOTS">
<? if(!empty($_POST['pay_autopay'])) {?>
<script src="http://wm-rb.net/include/ajax.js" type="text/javascript" language="JavaScript"></script>
<?}?>
</head>
<body bgcolor="#FFFFFF" text="#000000">

<center>
<table border="0" cellspacing="10" cellpadding="0" style="width: 900px; BORDER: #BDB76B 2px solid; background-color: #f3f7ff;">
	<tr>
	<td width="10%" align="center" class="div_include"><center>
	<a href="http://service.wm-rb.net"><img src="http://wm-rb.net/img/logo.gif" alt="WebMoney в Республике Беларусь" width="190" height="60"></a>
	</center>
	</td>
		<td width="90%" class="div_include" align="right">
<div style="float:left;" align="center"><br />
<span class="black">Наш WMID</span> &nbsp;&nbsp;&nbsp;&nbsp;<a href="http://passport.webmoney.ru/asp/certview.asp?wmid=409306109446" target="_blank" title="Здесь находится аттестат нашего WM идентификатора 409306109446">409306109446</a>
<div style="PADDING-TOP: 5px; PADDING-BOTTOM: 10px;" class="text">Бизнес уровень - <img src="https://stats.wmtransfer.com/Levels/pWMIDLevel.aspx?wmid=409306109446&amp;w=30&amp;h=15&amp;bg=#fcf" alt="Бизнес уровень данного аттестата" width="30" height="15" align="absmiddle"></div>

</div>
<div style="margin-left: 10px; float:right;">
Если у Вас возникли трудности с оплатой или другие вопросы касающиеся<br /> данного терминала, обращайтесь по указанным ниже контактам :<br />
<div style="margin-top:12px;"><b>ICQ:</b> <u>562-718-741</u> <b>|</b> <a href="http://wm-rb.net/support.aspx" target="_blank">Служба поддержки</a> <b>|</b> WMID : <a href="wmk:msgto?to=409306109446&amp;BringToFront=y" title="Отправить сообщение через WebMoney Keeper">409306109446</a></div>
</div>
</td>
	</tr>
	</table>
<div class="border" align="center">
<table width="100%" border="0" cellspacing="1" cellpadding="10" align="center" bgColor="#ebebeb">
                      <tr bgColor="#ffffff">
                        <td colspan="2" align="center" class="text_log">
<?
if(!empty($_GET['did'])) {
$info_check = $db->info_check($_GET['did']);
 $currency = $db_exchange->konst_currency('st_pay');
include($home_dir.'include/displ_kurs.aspx');
echo "
<SCRIPT type=\"text/javascript\">
<!--
function Check_pay() {
if (document.form_check.oplata.value == \"none\") {
alert('Выберите способ оплаты');
document.form_check.oplata.focus();
return false;
}
if(document.getElementById('purse').style.display=='block') {
if (!document.form_check.purse.value.match('^[0-9]{8}$') && !document.form_check.purse.value.match('^[0-9]{13}$') && !document.form_check.purse.value.match('^[0-9]{14}$')) {
alert('Счет отправителя указан не верно');
document.form_check.purse.focus();
return false;
}
}
}

// -->
</SCRIPT>
<form method=\"post\" id=\"form_check\" name=\"form_check\" action=\"http://service.wm-rb.net/payment.aspx\" onSubmit=\"return Check_pay()\">
<div class=div_include><b>Номер счета:</b> {$info_check[0]['did']}<br /><br />
<b>Выставленная сумма для оплаты:</b> {$info_check[0]['summa']} BYR<br /><br />
<b>Выберите способ оплаты:</b>
		<select name=\"oplata\" id=\"oplata\" onclick=\"ShowboxPay({$info_check[0]['summa']})\" onSelect=\"ShowboxPay({$info_check[0]['summa']})\" onFocus=\"ShowboxPay({$info_check[0]['summa']})\" onSelect=\"ShowboxPay({$info_check[0]['summa']})\" onKeyUp=\"ShowboxPay({$info_check[0]['summa']})\" onChange=\"ShowboxPay({$info_check[0]['summa']})\">
			<option value=\"none\" selected=\"selected\">Выберите валюту</option>";
	foreach($currency as $arr) {
			echo "<option value=\"{$arr['5']}\">{$arr['2']}</option>";
	}
		echo "</select><br /><br />
		<div id=\"box_kurs\" class=\"\"></div><br />
<div style=\"display: none; margin-bottom:10px;\" id=\"purse\">
<b>Счет отправителя :</b> <span id=\"form_purse\"></span></div>
<input type=\"hidden\" name=\"terminal\" value=\"{$info_check[0]['terminal']}\" readonly=\"readonly\">
<input type=\"hidden\" name=\"summa_pay\" value=\"\" readonly=\"readonly\">
<input type=\"hidden\" name=\"did\" value=\"{$_GET['did']}\" readonly=\"readonly\">
<input type=\"submit\" name=\"pay_autopay\" value=\"Продолжить\" style=\"margin-top:5px; width:120px;\"
					onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\">
<br /><br /></div>";
} ?>

<?if(!empty($_POST['add_autopay'])) {
echo "Ссылка для оплаты <a href=\"http://service.wm-rb.net/payment.aspx?did={$reqID}\">http://service.wm-rb.net/payment.aspx?did={$reqID}</a>";
}

//http://atm.wm-rb.net/nncron/exchange_pay.aspx
//https://merchant.webmoney.ru/lmi/payment.asp
if(!empty($_GET['add'])) {
echo "
<SCRIPT type=\"text/javascript\">
<!--
function Check() {
if (document.form_check.summa.value <= 0 && document.form_check.summa.value <= '0') {
alert('Вы не ввели сумму для перевода');
document.form_check.summa.focus();
return false;
}
}
// -->
</SCRIPT>
<form method=\"post\" id=\"form_check\" name=\"form_check\" action=\"http://service.wm-rb.net/payment.aspx\" onSubmit=\"return Check()\"><br />
Укажите сумму платежа :
<input type=\"text\" name=\"summa\" size=\"7\" id=\"summa\" value=\"\" > BYR<br />
<center><b>Эта сумма будет выставлена плательщику.</b></center>
<input type=\"hidden\" name=\"partner\" value=\"{$_GET['add']}\" readonly=\"readonly\">
<br /><br /><input type=\"submit\" name=\"add_autopay\" value=\"Создать счет\" style=\"margin-top:5px; width:120px;\"
					onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\"><br /><br />";
}



if(!empty($_POST['pay_autopay'])) {
	require($home_dir."include/constructor_exch.aspx");
	$Constructor = new Constructor();
	$info_check = $db->info_check($_POST['did']);
	$purse = $db_exchange->sel_purse($_POST['oplata'].'_service');
	$sel_idpay = $db_admin->sel_idpay($_POST['did']);
$desc_pay = "Cheque Payment ID:".$_POST['did'];
//print_r($_POST);
echo "
<div class=\"border\"><br />
	<b>Номер счета :</b> {$_POST['did']}<br /><br />
	<b>Для оплаты :</b> {$_POST['summa_pay']} <b>{$_POST['oplata']}</b><br />

<br /><br />
";
				if($_POST['oplata'] == "EasyPay") {
$Constructor->ParamertyAutoPayment($_POST['oplata'],$info_check[0]['purse'],$info_check[0]['summa_pay'],$sel_idpay[0]["id_pay"],$desc_pay,$_POST['did']);
				}
				else {
$Constructor->ParamertyAutoPayment($_POST['oplata'],$purse[0]['purse'],$info_check[0]['summa_pay'],$sel_idpay[0]["id_pay"],$desc_pay,$_POST['did']);}

echo "<br /></div>";
}
?>

</form>
						</td>
                      </tr>
					  </table>


</div>
</center>
</body>
</html>
