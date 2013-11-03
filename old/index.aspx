<?php
require("const.inc.aspx");
require($home_dir."customsql.inc.aspx");
require($home_dir."include/header.aspx");


$db = new CustomSQL($DBName);
$db_exchange = new CustomSQL_exchange($DBName_exchange);
$db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Service.wm-rb.net : Прием платежей, мобильная связь, коммунальные платежи</title>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<link rel="stylesheet" href="http://service.wm-rb.net/style.css" type="text/css">
<Meta name="description" Content="Автоматическое пополнение счета мобильного телефона Velcom, МТС, Life:), интернет-оператора ByFly и прочие, коммунальные платежи.">
<Meta name="keywords" Content="коммунальные платежи, пин-коды, карты экспресс-оплаты, пополнение счета, интернет-оператор, автоматическое пополнение, мобильный телефон, оплата, Velcom, MTS, life, Dialog, ByFly Белтелеком, Космос ТВ, УЖХ, Минск, Могилев, Мозырь, Молодечно, Бобруйск, Молодечно-межрайгаз, Молодечно-водоканал, ГомельЭнерго, МинскЭнерго, Атлант Телеком, ByFly, Айчына Плюс, Шпаркi Дамавiк">
<link REL="shortcut icon" HREF="http://wm-rb.net/img/favicon.ico" TYPE="image/x-icon">
<META content="index,follow,all" name="robots">
<META NAME="COPYRIGHT" CONTENT="Copyright (c) by Wm-Rb.net">
<script language='JavaScript'>
<!--
function Check() {

if (document.form_uslugi.oplata.value == "none") {
alert('Выберите способ оплаты');
document.form_uslugi.oplata.focus();
return false;
}
return true;
}
function showbox(name_box){
    document.getElementById(name_box).style.display = 'block';
    return false;
}
function hidebox(name_box){
    document.getElementById(name_box).style.display = 'none';
    return false;
}
// -->
</SCRIPT>
</head>
<body bgcolor="#FFFFFF" text="#000000">

<center>

	<? include('include/top.aspx');?>
<center><div style="width:600px" id="report">Для мгновенного пополнения счета мобильных операторов Velcom и Life:), а также интернет-оператора ByFly и других воспользуйтесь нашим <a href="http://shop.wm-rb.net/" target="_blank">магазином пин-кодов</a>. Карты экспресс-оплаты Вы сможете приобрести по самым низким ценам в сети. Приходите будет рады Вам!</div></center><br /><br />
<form method="post" action="http://service.wm-rb.net/services_demand.aspx" name="form_uslugi" id="form_uslugi"  onSubmit="return Check()">

	<table width="500" border="0" cellspacing="1" cellpadding="7" bgColor="#C0C0C0">
<?
 $uslugi = $db_pay_desk->sel_uslugi('Internet');
 $uslugi_more = $db_pay_desk->sel_uslugi('InternetBF');
$count = 1;
if(!empty($uslugi)) {
	echo "<tr bgColor=\"#f3f7ff\">
		<td colspan=\"2\" align=\"right\" valign=\"top\" class=\"text\"><u>Интернет-операторы</u></td>
	</tr>";
//вывод подкатегории
	if(!empty($uslugi_more)) {
	echo "<tr bgColor=\"#ffffff\">
		<td width=\"100%\" colspan=2 align=\"left\" valign=\"top\" class=\"text_log\">


					<img src=\"http://wm-rb.net/img/folder.gif\" width=\"13\" height=\"12\" />&nbsp;<A hideFocus href=\"services_list.aspx\" onclick=\"return showbox('boxBF');\">BYFLY.BY</A>

	  <DIV id=boxBF style=\"BORDER: #556B2F 1px solid; DISPLAY: none; LEFT: 0px; POSITION: relative; TOP: 5px; BACKGROUND: #ffffff; padding-left:2px; padding-top:2px; margin-bottom:10px;\">
  <IMG title=Закрыть style=\"right: 5px; POSITION: absolute; TOP: 0px; CURSOR: pointer; float:right; margin:5px;\"
            onclick=hidebox('boxBF'); height=14 src=\"http://wm-rb.net/img/close.gif\" width=16 alt=Закрыть border=0>
<TABLE cellSpacing=0 cellPadding=1 width=450 border=0>";
if(date("H:i") < "23:00" && date("H:i") > "08:00") {
	foreach($uslugi_more as $arr) {
echo "<tr bgColor=\"#ffffff\">
		<td width=\"150\" align=\"left\" class=\"text_log\"><input type=\"radio\" name=\"usluga\" id=\"usluga\" value=\"{$arr['1']}\" style=\"BACKGROUND-COLOR: #ffffff; border-color : #ffffff;\">&nbsp;{$arr['0']}</td>
</tr>
";
	}
}
else {echo "<b>Оплата услуг интернет-провайдера byfly возможна<br />только в период с 8:00 до 23:00</b>";}
	echo "</table>
</DIV>

		</td>

	</tr>";
	}
	foreach($uslugi as $arr) {

	echo "<tr bgColor=\"#ffffff\">
		<td width=\"40%\" align=\"left\" valign=\"top\" class=\"text_log\"><input type=\"radio\" ";
		if ($count == "1") echo "checked=1 ";
		echo " name=\"usluga\" value=\"{$arr['1']}\" style=\"BACKGROUND-COLOR: #ffffff; border-color : #ffffff;\">&nbsp;{$arr['2']}</td>
		<td width=\"60%\" align=\"left\" valign=\"top\" class=\"text_log\">{$arr['0']}</td>
	</tr>";
	$count++;
	}
}
$uslugi = $db_pay_desk->sel_uslugi('Mobile');
$uslugi_more = $db_pay_desk->sel_uslugi('MobileTEL');
if(!empty($uslugi)) {
	echo "<tr bgColor=\"#f3f7ff\">
		<td colspan=\"2\" align=\"right\" valign=\"top\" class=\"text\"><u>Услуги связи</u></td>
	</tr>";

//вывод подкатегории
	if(!empty($uslugi_more)) {
	echo "<tr bgColor=\"#ffffff\">
		<td width=\"100%\" colspan=2 align=\"left\" valign=\"top\" class=\"text_log\">


					<img src=\"http://wm-rb.net/img/folder.gif\" width=\"13\" height=\"12\" />&nbsp;<A hideFocus href=\"services_list.aspx\" onclick=\"return showbox('boxTEL');\">Белтелеком</A>

	  <DIV id=boxTEL style=\"BORDER: #556B2F 1px solid; DISPLAY: none; LEFT: 0px; POSITION: relative; TOP: 5px; BACKGROUND: #ffffff; padding-left:2px; padding-top:2px; margin-bottom:10px;\">
  <IMG title=Закрыть style=\"right: 5px; POSITION: absolute; TOP: 0px; CURSOR: pointer; float:right; margin:5px;\"
            onclick=hidebox('boxTEL'); height=14 src=\"http://wm-rb.net/img/close.gif\" width=16 alt=Закрыть border=0>
<TABLE cellSpacing=0 cellPadding=1 width=450 border=0>";
	foreach($uslugi_more as $arr) {
echo "<tr bgColor=\"#ffffff\">
		<td width=\"150\" align=\"left\" class=\"text_log\"><input type=\"radio\" name=\"usluga\" id=\"usluga\" value=\"{$arr['1']}\" style=\"BACKGROUND-COLOR: #ffffff; border-color : #ffffff;\">&nbsp;{$arr['0']}</td>
</tr>
";
	}
	echo "</table>
</DIV>

		</td>

	</tr>";
	}
	foreach($uslugi as $arr) {

	echo "<tr bgColor=\"#ffffff\">
		<td width=\"40%\" align=\"left\" valign=\"top\" class=\"text_log\"><input type=\"radio\" name=\"usluga\" id=\"usluga\" value=\"{$arr['1']}\" style=\"BACKGROUND-COLOR: #ffffff; border-color : #ffffff;\">&nbsp;{$arr['2']}</td>
		<td width=\"60%\" align=\"left\" valign=\"top\" class=\"text_log\">{$arr['0']}</td>
	</tr>";
	}
}
 $uslugi = $db_pay_desk->sel_uslugi('TV');
if(!empty($uslugi)) {
	echo "<tr bgColor=\"#f3f7ff\">
		<td colspan=\"2\" align=\"right\" valign=\"top\" class=\"text\"><u>Кабельное телевидение</u></td>
	</tr>";
	foreach($uslugi as $arr) {

	echo "<tr bgColor=\"#ffffff\">
		<td width=\"40%\" align=\"left\" valign=\"top\" class=\"text_log\"><input type=\"radio\" name=\"usluga\" id=\"usluga\" value=\"{$arr['1']}\" style=\"BACKGROUND-COLOR: #ffffff; border-color : #ffffff;\">&nbsp;{$arr['2']}</td>
		<td width=\"60%\" align=\"left\" valign=\"top\" class=\"text_log\">{$arr['0']}</td>
	</tr>";
	}
}
 $uslugi = $db_pay_desk->sel_uslugi('Komunal');
if(!empty($uslugi)) {
	echo "<tr bgColor=\"#f3f7ff\">
		<td colspan=\"2\" align=\"right\" valign=\"top\" class=\"text\"><u>Коммунальные услуги</u></td>
	</tr>";

	foreach($uslugi as $arr) {

	echo "<tr bgColor=\"#ffffff\">
		<td width=\"40%\" align=\"left\" valign=\"top\" class=\"text_log\"><input type=\"radio\" name=\"usluga\" id=\"usluga\" value=\"{$arr['1']}\" style=\"BACKGROUND-COLOR: #ffffff; border-color : #ffffff;\">&nbsp;{$arr['2']}</td>
		<td width=\"60%\" align=\"left\" valign=\"top\" class=\"text_log\">{$arr['0']}</td>
	</tr>";
	}
}
?>
	<tr bgColor="#ffffff">
		<td colspan="2" align="center" valign="top" class="text">

			<select name="oplata"  id="oplata" >
			<option value="none" selected="selected">Выберите валюту</option>
<? $currency = $db_exchange->konst_currency('st_pay');
	foreach($currency as $arr) {
			echo "<option value=\"{$arr['5']}\">{$arr['2']}</option>";
	}
?>
		</select>
		</td>
	</tr>
	<tr bgColor="#f3f7ff">
		<td colspan="2" align="center" valign="top" class="text">
		<input type="hidden" name="type_usluga" value="uslugi" readonly="readonly">
				<input type="submit" name="oplata_usluga" value="Отправить" style="width:100px;
		    "onmouseover="this.style.backgroundColor='#E8E8FF';" onmouseout="this.style.backgroundColor='#f3f7ff';"
		    id="cursor"/></td>
	</tr>
	</table>
</form>
<? include('include/bottom.aspx');?>

</body>
</html>
