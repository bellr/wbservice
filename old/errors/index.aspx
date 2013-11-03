<?php
if ($_GET['id'] == "403") {
	$error_message = "Ошибка 403 - пользователь не прошел аутентификацию, запрет на доступ";
}
if ($_GET['id'] == "404") {
	$error_message = "Ошибка 404 - запрашиваемый документ не найден";
}
if ($_GET['id'] == "500") {
	$error_message = "Ошибка 500 - внутренняя ошибка сервера";
}

require("../customsql.inc.aspx");
$db = new CustomSQL($DBName);

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<Title>WM-RB.net - Сервис электронных платежей :: <? echo $error_message; ?></Title>
<Meta name="description" Content="Автоматизированный обменник электронных валют WebMoney (WMZ, WMB, WMR, WME, WMU, WMY), EasyPay, RBK Money, Yandex Money, коммунальные платежи и услуги">
<Meta name="keywords" Content="обменный пункт, автоматизированный обменник, exchange, электронные деньги, wmb, wmz, wmr, wme, easypay, rbk money, yandex money, автоматизированный обмен, автоматизированный автомат, обмен цифровых денег, обмен wm, электронные денеги в Беларуси, пополнение ввод вывод WebMoney в Минске, обменять webmoney, курсы, обмен валют, обменник, Минск, Беларусь, заработок, ВебМани, интернет-деньги, БелГазПром банк, online change, баланс телефона, пополнение, оплата, коммунальные платежи и услуги, свет, газ, мобильной связи, мобильный, партнерская программа">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<META NAME="RESOURCE-TYPE" CONTENT="DOCUMENT">
<META content="30 days" name="revisit-after">
<META content="index,follow,all" name="robots">
<META name="author" content="AtomLy">
<META NAME="COPYRIGHT" CONTENT="Copyright (c) by Wm-Rb.net">
<link rel="stylesheet" href="http://wm-rb.net/style.css" type="text/css">
<link REL="shortcut icon" HREF="http://wm-rb.net/img/favicon.ico" TYPE="image/x-icon">
</SCRIPT>
</head>

<body>
<?
include('../include/top.aspx');
?>


	<tr>
	<td align="center" valign="middle" class="div_include"><h2 style="margin-top:190px;"><? echo $error_message; ?></h2></td>
	</tr>
<?
include('../include/bottom.aspx');
?>
</body>
</html>
